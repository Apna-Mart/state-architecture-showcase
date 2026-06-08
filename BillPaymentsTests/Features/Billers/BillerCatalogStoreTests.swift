import Foundation
import Testing
@testable import BillPayments

@MainActor
struct BillerCatalogStoreTests {

    private func makeSettings(systemLanguage: @escaping () -> String = { "en" }) -> SettingsStore {
        SettingsStore(
            repository: StoredSettingsRepository(store: InMemoryKeyValueStore()),
            systemLanguage: systemLanguage,
            readLanguageOverride: { nil },
            writeLanguageOverride: { _ in }
        )
    }

    private func awaitInitialFetch(_ store: BillerCatalogStore) async {
        await waitUntil { store.catalog.valueOrNull != nil }
    }

    private func makeStore(
        repository: BillerRepository,
        settings: SettingsStore,
        clock: Clock
    ) -> BillerCatalogStore {
        BillerCatalogStore(repository: repository, settingsStore: settings, clock: clock)
    }

    @Test func loadsCatalogWith60BillersAnd15Categories() async {
        let store = makeStore(
            repository: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
            settings: makeSettings(),
            clock: FixedClock(current: Date(timeIntervalSince1970: 0))
        )
        await awaitInitialFetch(store)
        let catalog = store.catalog.valueOrNull
        #expect(catalog != nil)
        #expect(catalog?.categories.count == 15)
        #expect(catalog?.billers.count == 60)
    }

    @Test func languageChangeRefetchesLocalizedCatalog() async {
        var systemLanguage = "en"
        let settings = makeSettings(systemLanguage: { systemLanguage })
        let store = makeStore(
            repository: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
            settings: settings,
            clock: FixedClock(current: Date(timeIntervalSince1970: 0))
        )
        await awaitInitialFetch(store)
        #expect(store.catalog.valueOrNull?.categoryById("electricity")?.name == "Electricity")
        systemLanguage = "hi"
        settings.refreshLanguage()
        for _ in 0..<100 {
            await store.pendingWork?.value
            if store.catalog.valueOrNull?.categoryById("electricity")?.name == "बिजली" { break }
            await Task.yield()
        }
        #expect(store.catalog.valueOrNull?.categoryById("electricity")?.name == "बिजली")
    }

    @Test func refreshIfStaleOnlyRefetchesPastMaxAge() async {
        let clock = FixedClock(current: Date(timeIntervalSince1970: 0))
        let repository = CountingBillerRepository(
            delegate: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1))
        )
        let store = makeStore(repository: repository, settings: makeSettings(), clock: clock)
        await awaitInitialFetch(store)
        #expect(repository.fetchCount == 1)
        store.refreshIfStale()
        await store.pendingWork?.value
        #expect(repository.fetchCount == 1)
        clock.advance(by: 31 * 60)
        store.refreshIfStale()
        await store.pendingWork?.value
        #expect(repository.fetchCount == 2)
    }

    @Test func billerIdsComposeCategoryAndPrefix() async {
        let store = makeStore(
            repository: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
            settings: makeSettings(),
            clock: FixedClock(current: Date(timeIntervalSince1970: 0))
        )
        await awaitInitialFetch(store)
        let catalog = store.catalog.valueOrNull
        let biller = catalog?.billerById("electricity-national")
        #expect(biller != nil)
        #expect(biller?.mode == .presentment)
        #expect(catalog?.billerById("dth-metro")?.mode == .openAmount)
        #expect(catalog?.billerById("credit-card-city")?.inputParams.count == 2)
    }
}

final class CountingBillerRepository: BillerRepository {
    private let delegate: BillerRepository
    private(set) var fetchCount = 0

    init(delegate: BillerRepository) {
        self.delegate = delegate
    }

    func fetchCatalog(language: String) async throws -> BillerCatalog {
        fetchCount += 1
        return try await delegate.fetchCatalog(language: language)
    }

    func search(query: String, language: String) async throws -> [Biller] {
        try await delegate.search(query: query, language: language)
    }
}

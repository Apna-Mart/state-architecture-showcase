import Foundation
import Testing
@testable import BillPayments

@MainActor
private final class LanguageBox {
    var value = "en"
}

@MainActor
private final class Fixture {
    let language = LanguageBox()
    let settings: SettingsStore
    let repository: FakeBillerRepository
    let catalog: BillerCatalogStore
    let model: SearchScreenModel
    let languageTask: Task<Void, Never>

    init() {
        let language = self.language
        settings = SettingsStore(
            repository: StoredSettingsRepository(store: InMemoryKeyValueStore()),
            systemLanguage: { language.value },
            readLanguageOverride: { nil },
            writeLanguageOverride: { _ in }
        )
        repository = FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0))
        catalog = BillerCatalogStore(
            repository: repository,
            settingsStore: settings,
            clock: FixedClock(current: Date(timeIntervalSince1970: 0))
        )
        let model = SearchScreenModel(
            repository: repository,
            catalogStore: catalog,
            settingsStore: settings,
            debounce: .zero
        )
        self.model = model
        languageTask = Task { await model.consumeLanguageChanges() }
    }

    deinit {
        languageTask.cancel()
    }

    func awaitCatalog() async {
        await waitUntil { catalog.catalog.valueOrNull != nil }
    }

    func awaitSearch() async {
        await Task.yield()
        await model.searchWork?.value
    }
}

@MainActor
struct SearchScreenModelTests {

    @Test func shortQueryStaysIdle() async {
        let fixture = Fixture()
        await fixture.awaitCatalog()
        fixture.model.editQuery("m")
        await fixture.awaitSearch()
        #expect(fixture.model.data == .idle)
    }

    @Test func queryYieldsMatchingResultsWithCategoryNames() async {
        let fixture = Fixture()
        await fixture.awaitCatalog()
        fixture.model.editQuery("metro")
        #expect(fixture.model.data == .searching)
        await fixture.awaitSearch()
        guard case let .results(billers) = fixture.model.data else {
            Issue.record("expected results, got \(fixture.model.data)")
            return
        }
        #expect(billers.count == 15)
        #expect(billers.first { $0.id == "electricity-metro" }?.categoryName == "Electricity")
    }

    @Test func noMatchYieldsEmptyWithQuery() async {
        let fixture = Fixture()
        await fixture.awaitCatalog()
        fixture.model.editQuery("zzzz")
        await fixture.awaitSearch()
        #expect(fixture.model.data == .empty(query: "zzzz"))
    }

    @Test func languageChangeRefetchesResults() async {
        let fixture = Fixture()
        await fixture.awaitCatalog()
        fixture.model.editQuery("metro")
        await fixture.awaitSearch()
        #expect({ if case .results = fixture.model.data { return true } else { return false } }())
        fixture.language.value = "hi"
        fixture.settings.refreshLanguage()
        await waitUntil { fixture.model.data == .empty(query: "metro") }
        #expect(fixture.model.data == .empty(query: "metro"))
    }
}

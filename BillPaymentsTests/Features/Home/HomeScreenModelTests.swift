import Foundation
import Synchronization
import Testing
@testable import BillPayments

private struct FixedDateStream: DateStream {
    let date: Date

    func dates() -> AsyncStream<Date> {
        AsyncStream { continuation in
            continuation.yield(date)
            continuation.finish()
        }
    }
}

@MainActor
private final class Fixture {
    let keyValueStore = InMemoryKeyValueStore()
    let bus = UiEventBus()
    let clock: FixedClock
    let auth: AuthStore
    let settings: SettingsStore
    let catalog: BillerCatalogStore
    let saved: SavedBillersStore
    let dueBills: DueBillsStore
    let model: HomeScreenModel

    init() {
        let fixed = FixedClock(current: Date(timeIntervalSince1970: 1_749_290_400))
        clock = fixed
        auth = AuthStore(
            authRepository: FakeAuthRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0)),
            sessionRepository: StoredSessionRepository(store: keyValueStore),
            events: bus
        )
        settings = SettingsStore(
            repository: StoredSettingsRepository(store: keyValueStore),
            systemLanguage: { "en" },
            readLanguageOverride: { nil },
            writeLanguageOverride: { _ in }
        )
        catalog = BillerCatalogStore(
            repository: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0)),
            settingsStore: settings,
            clock: fixed
        )
        saved = SavedBillersStore(authStore: auth, repository: StoredSavedBillersRepository(store: keyValueStore), events: bus)
        dueBills = DueBillsStore(
            authStore: auth,
            savedBillersStore: saved,
            repository: FakeBillRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0), clock: fixed),
            clock: fixed
        )
        model = HomeScreenModel(
            catalogStore: catalog,
            savedBillersStore: saved,
            dueBillsStore: dueBills,
            dateStream: FixedDateStream(date: fixed.now())
        )
    }

    func login() async {
        auth.sendOtp(phone: "9876543210")
        await auth.pendingWork?.value
        auth.verifyOtp(code: "123456")
        await auth.pendingWork?.value
        await waitUntil { saved.userId != nil }
    }

    func awaitCatalog() async {
        await waitUntil { catalog.catalog.valueOrNull != nil }
    }

    func awaitDueBills() async {
        await waitUntil { dueBills.dueBills.valueOrNull?.isEmpty == false }
    }

    func feedToday() async {
        await model.consumeDates()
    }
}

@MainActor
struct HomeScreenModelTests {

    @Test func categoriesLoadFromCatalog() async {
        let fixture = Fixture()
        await fixture.login()
        await fixture.awaitCatalog()
        guard case let .loaded(items) = fixture.model.categoriesData else {
            Issue.record("expected loaded, got \(fixture.model.categoriesData)")
            return
        }
        #expect(items.count == 15)
    }

    @Test func remindersExcludeOpenAmountBillers() async {
        let fixture = Fixture()
        await fixture.login()
        await fixture.awaitCatalog()
        fixture.saved.save(SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home"))
        fixture.saved.save(SavedBiller(billerId: "dth-metro", account: "777", nickname: "TV"))
        await fixture.awaitDueBills()
        await fixture.feedToday()
        guard case let .loaded(items) = fixture.model.remindersData else {
            Issue.record("expected loaded, got \(fixture.model.remindersData)")
            return
        }
        #expect(items.map(\.billerId) == ["electricity-national"])
    }

    @Test func savedBillersSectionDoesNotEmitWhenRemindersRefetch() async {
        let fixture = Fixture()
        await fixture.login()
        await fixture.awaitCatalog()
        fixture.saved.save(SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home"))
        await fixture.awaitDueBills()

        let savedSectionFired = Mutex(false)
        withObservationTracking {
            _ = fixture.model.savedBillersData
        } onChange: {
            savedSectionFired.withLock { $0 = true }
        }

        fixture.dueBills.invalidate()
        await fixture.dueBills.pendingWork?.value
        await Task.yield()

        #expect(savedSectionFired.withLock { $0 } == false)
    }
}

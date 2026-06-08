import Foundation
import Testing
@testable import BillPayments

@MainActor
private final class AppGraph {
    let keyValueStore: InMemoryKeyValueStore
    let bus = UiEventBus()
    let clock = FixedClock(current: Date(timeIntervalSince1970: 1_780_000_000))

    let authStore: AuthStore
    let settingsStore: SettingsStore
    let savedBillersStore: SavedBillersStore
    let catalogStore: BillerCatalogStore
    let dueBillsStore: DueBillsStore
    let paymentsStore: PaymentsStore

    init(keyValueStore: InMemoryKeyValueStore = InMemoryKeyValueStore()) {
        self.keyValueStore = keyValueStore

        let network = MockNetwork(minDelayMs: 0, maxDelayMs: 0, failEvery: 1000)

        authStore = AuthStore(
            authRepository: FakeAuthRepository(network: network),
            sessionRepository: StoredSessionRepository(store: keyValueStore),
            events: bus
        )
        settingsStore = SettingsStore(
            repository: StoredSettingsRepository(store: keyValueStore),
            systemLanguage: { "en" },
            readLanguageOverride: { nil },
            writeLanguageOverride: { _ in }
        )
        savedBillersStore = SavedBillersStore(
            authStore: authStore,
            repository: StoredSavedBillersRepository(store: keyValueStore),
            events: bus
        )
        catalogStore = BillerCatalogStore(
            repository: FakeBillerRepository(network: network),
            settingsStore: settingsStore,
            clock: clock
        )
        dueBillsStore = DueBillsStore(
            authStore: authStore,
            savedBillersStore: savedBillersStore,
            repository: FakeBillRepository(network: network, clock: clock),
            clock: clock
        )
        paymentsStore = PaymentsStore(
            authStore: authStore,
            paymentRepository: FakePaymentRepository(network: network),
            historyRepository: StoredPaymentHistoryRepository(store: keyValueStore),
            invalidateDueBills: dueBillsStore.invalidate,
            events: bus,
            clock: clock
        )
    }

    func login() async {
        authStore.sendOtp(phone: "9876543210")
        await authStore.pendingWork?.value
        authStore.verifyOtp(code: "123456")
        await authStore.pendingWork?.value
        await waitUntil { savedBillersStore.userId != nil }
    }
}

@MainActor
struct AppSmokeTests {

    @Test func coldStartIsUnauthenticated() {
        let graph = AppGraph()
        #expect(graph.authStore.state.userIdOrNull == nil)
        #expect(graph.savedBillersStore.state.items.isEmpty)
        #expect(graph.paymentsStore.state.items.isEmpty)
    }

    @Test func loginAuthenticates() async {
        let graph = AppGraph()
        await graph.login()
        #expect(graph.authStore.state.userIdOrNull == "user-9876543210")
    }

    @Test func catalogLoadsSixtyBillers() async {
        let graph = AppGraph()
        await waitUntil { graph.catalogStore.catalog.valueOrNull != nil }
        #expect(graph.catalogStore.catalog.valueOrNull?.billers.count == 60)
        #expect(graph.catalogStore.catalog.valueOrNull?.categories.count == 15)
    }

    @Test func saveBillerTriggersDueBillFetch() async {
        let graph = AppGraph()
        await graph.login()
        graph.savedBillersStore.save(
            SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home")
        )
        await waitUntil { graph.dueBillsStore.dueBills.valueOrNull?.isEmpty == false }
        #expect(graph.savedBillersStore.state.items.count == 1)
        #expect(graph.dueBillsStore.dueBills.valueOrNull?.count == 1)
    }

    @Test func paymentSucceedsEmitsStartedAndInvalidatesDueBills() async {
        let graph = AppGraph()
        await graph.login()
        graph.savedBillersStore.save(
            SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home")
        )
        await waitUntil { graph.dueBillsStore.dueBills.valueOrNull?.isEmpty == false }

        var iterator = graph.bus.events.makeAsyncIterator()
        graph.paymentsStore.pay(
            billerId: "electricity-national",
            billerName: "National Electricity",
            categoryId: "electricity",
            account: "12345",
            amountPaise: 50_000
        )
        #expect(graph.paymentsStore.state.items.first?.status == .processing)
        #expect(await iterator.next() == .paymentStarted(paymentId: "pay-1"))

        await graph.paymentsStore.pendingWork?.value
        await graph.dueBillsStore.pendingWork?.value

        #expect(graph.paymentsStore.state.items.count == 1)
        #expect(graph.paymentsStore.state.items.first?.status == .success)
        #expect(graph.dueBillsStore.dueBills.valueOrNull?.count == 1)
    }

    @Test func sessionAndHistoryRestoreAcrossFreshGraph() async {
        let keyValueStore = InMemoryKeyValueStore()
        let first = AppGraph(keyValueStore: keyValueStore)
        await first.login()
        first.savedBillersStore.save(
            SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home")
        )
        await first.savedBillersStore.pendingWork?.value
        first.paymentsStore.pay(
            billerId: "electricity-national",
            billerName: "National Electricity",
            categoryId: "electricity",
            account: "12345",
            amountPaise: 50_000
        )
        await first.paymentsStore.pendingWork?.value

        let second = AppGraph(keyValueStore: keyValueStore)
        #expect(second.authStore.state.userIdOrNull == "user-9876543210")
        #expect(second.savedBillersStore.state.items.count == 1)
        #expect(second.paymentsStore.state.items.count == 1)
        #expect(second.paymentsStore.state.items.first?.status == .success)
    }
}

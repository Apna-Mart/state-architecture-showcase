import Foundation
import Testing
@testable import BillPayments

struct PaymentsStoreTests {

    private final class Flag {
        var value = false
    }

    private final class Fixture {
        let keyValueStore: InMemoryKeyValueStore
        let bus = UiEventBus()
        let clock = FixedClock(current: Date(timeIntervalSince1970: 1_780_000_000))
        let auth: AuthStore
        let store: PaymentsStore

        init(
            keyValueStore: InMemoryKeyValueStore = InMemoryKeyValueStore(),
            paymentNetwork: MockNetwork = MockNetwork(minDelayMs: 0, maxDelayMs: 0, failEvery: 1000),
            invalidateDueBills: @escaping () -> Void = {}
        ) {
            self.keyValueStore = keyValueStore
            self.auth = AuthStore(
                authRepository: FakeAuthRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0)),
                sessionRepository: StoredSessionRepository(store: keyValueStore),
                events: bus
            )
            self.store = PaymentsStore(
                authStore: auth,
                paymentRepository: FakePaymentRepository(network: paymentNetwork),
                historyRepository: StoredPaymentHistoryRepository(store: keyValueStore),
                invalidateDueBills: invalidateDueBills,
                events: bus,
                clock: clock
            )
        }

        func login() async {
            auth.sendOtp(phone: "9876543210")
            await auth.pendingWork?.value
            auth.verifyOtp(code: "123456")
            await auth.pendingWork?.value
            await waitUntil { store.userId != nil }
        }

        func pay() {
            store.pay(
                billerId: "electricity-national",
                billerName: "National Electricity",
                categoryId: "electricity",
                account: "12345",
                amountPaise: 50_000
            )
        }
    }

    @Test func successfulPaymentTransitionsProcessingToSuccess() async {
        let fixture = Fixture()
        await fixture.login()
        var iterator = fixture.bus.events.makeAsyncIterator()
        fixture.pay()
        #expect(fixture.store.state.items.first?.status == .processing)
        #expect(await iterator.next() == .paymentStarted(paymentId: "pay-1"))
        await fixture.store.pendingWork?.value
        #expect(fixture.store.state.items.count == 1)
        #expect(fixture.store.state.items.first?.status == .success)
    }

    @Test func declinedPaymentTransitionsToFailedAndEmits() async {
        let fixture = Fixture(paymentNetwork: MockNetwork(minDelayMs: 0, maxDelayMs: 0, failEvery: 1))
        await fixture.login()
        var iterator = fixture.bus.events.makeAsyncIterator()
        fixture.pay()
        #expect(await iterator.next() == .paymentStarted(paymentId: "pay-1"))
        await fixture.store.pendingWork?.value
        #expect(fixture.store.state.items.first?.status == .failed)
        #expect(await iterator.next() == .paymentFailed(paymentId: "pay-1"))
    }

    @Test func duplicatePayForSameBillerAccountIgnoredWhileProcessing() async {
        let fixture = Fixture()
        await fixture.login()
        fixture.pay()
        fixture.pay()
        #expect(fixture.store.state.items.count == 1)
        await fixture.store.pendingWork?.value
    }

    @Test func paymentsPersistAndRestoreAcrossStoreGraphs() async {
        let keyValueStore = InMemoryKeyValueStore()
        let fixture = Fixture(keyValueStore: keyValueStore)
        await fixture.login()
        fixture.pay()
        await fixture.store.pendingWork?.value
        let restored = StoredPaymentHistoryRepository(store: keyValueStore).restore(userId: "user-9876543210")
        #expect(restored.items.count == 1)
        #expect(restored.items.first?.status == .success)
        #expect(restored.nextId == 2)
    }

    @Test func interruptedProcessingRestoresAsFailed() async throws {
        let keyValueStore = InMemoryKeyValueStore()
        let repository = StoredPaymentHistoryRepository(store: keyValueStore)
        let processing = Payment(
            id: "pay-1",
            billerId: "electricity-national",
            billerName: "National Electricity",
            categoryId: "electricity",
            account: "12345",
            amountPaise: 50_000,
            paidAtUtc: Date(timeIntervalSince1970: 1_780_000_000),
            status: .processing
        )
        try await repository.persist(userId: "user-9876543210", value: Payments(items: [processing], nextId: 2))
        let restored = repository.restore(userId: "user-9876543210")
        #expect(restored.items.first?.status == .failed)
    }

    @Test func logoutDuringPaymentDiscardsStaleCompletion() async {
        let fixture = Fixture()
        await fixture.login()
        fixture.pay()
        fixture.auth.logout()
        await fixture.auth.pendingWork?.value
        await fixture.store.pendingWork?.value
        await waitUntil { fixture.store.state.items.isEmpty }
        #expect(fixture.store.state.items.isEmpty)
    }

    @Test func successfulPaymentInvalidatesDueBills() async {
        let flag = Flag()
        let fixture = Fixture(invalidateDueBills: { flag.value = true })
        await fixture.login()
        fixture.pay()
        await fixture.store.pendingWork?.value
        #expect(flag.value)
    }
}

import Foundation
import Testing
@testable import BillPayments

@MainActor
struct ReceiptScreenModelTests {

    private final class Fixture {
        let keyValueStore = InMemoryKeyValueStore()
        let bus = UiEventBus()
        let clock = FixedClock(current: Date(timeIntervalSince1970: 1_780_000_000))
        let auth: AuthStore
        let saved: SavedBillersStore
        let payments: PaymentsStore

        init(paymentNetwork: MockNetwork = MockNetwork(minDelayMs: 0, maxDelayMs: 0, failEvery: 1000)) {
            auth = AuthStore(
                authRepository: FakeAuthRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0)),
                sessionRepository: StoredSessionRepository(store: keyValueStore),
                events: bus
            )
            saved = SavedBillersStore(
                authStore: auth,
                repository: StoredSavedBillersRepository(store: keyValueStore),
                events: bus
            )
            payments = PaymentsStore(
                authStore: auth,
                paymentRepository: FakePaymentRepository(network: paymentNetwork),
                historyRepository: StoredPaymentHistoryRepository(store: keyValueStore),
                invalidateDueBills: {},
                events: bus,
                clock: clock
            )
        }

        func login() async {
            auth.sendOtp(phone: "9876543210")
            await auth.pendingWork?.value
            auth.verifyOtp(code: "123456")
            await auth.pendingWork?.value
            await waitUntil { saved.userId != nil && payments.userId != nil }
        }

        func pay() {
            payments.pay(
                billerId: "electricity-national",
                billerName: "National Electricity",
                categoryId: "electricity",
                account: "12345",
                amountPaise: 50_000
            )
        }

        func model(paymentId: String) -> ReceiptScreenModel {
            ReceiptScreenModel(paymentsStore: payments, savedBillersStore: saved, paymentId: paymentId)
        }
    }

    @Test func unknownPaymentIsNotFound() async {
        let fixture = Fixture()
        await fixture.login()
        let model = fixture.model(paymentId: "pay-99")
        #expect(model.data == .notFound)
    }

    @Test func processingPaymentProjectsProcessing() async {
        let fixture = Fixture()
        await fixture.login()
        fixture.pay()
        let model = fixture.model(paymentId: "pay-1")
        guard case .processing = model.data else { Issue.record("expected processing"); return }
        await fixture.payments.pendingWork?.value
    }

    @Test func successProjectsSuccessWithSaveBillerOffer() async {
        let fixture = Fixture()
        await fixture.login()
        fixture.pay()
        await fixture.payments.pendingWork?.value
        let model = fixture.model(paymentId: "pay-1")
        guard case let .success(_, _, _, _, _, _, canSaveBiller) = model.data, canSaveBiller
        else { Issue.record("expected success offering save"); return }
        model.saveBiller(nickname: "Home")
        await fixture.saved.pendingWork?.value
        guard case let .success(_, _, _, _, _, _, updatedCanSave) = model.data
        else { Issue.record("expected success"); return }
        #expect(!updatedCanSave)
        #expect(fixture.saved.state.items == [SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home")])
    }

    @Test func failureProjectsFailedWithRetry() async {
        let fixture = Fixture(paymentNetwork: MockNetwork(minDelayMs: 0, maxDelayMs: 0, failEvery: 1))
        await fixture.login()
        fixture.pay()
        await fixture.payments.pendingWork?.value
        let model = fixture.model(paymentId: "pay-1")
        guard case .failed = model.data else { Issue.record("expected failed"); return }
    }
}

import Foundation
import Testing
@testable import BillPayments

@MainActor
struct BillReviewScreenModelTests {

    private final class Fixture {
        let keyValueStore = InMemoryKeyValueStore()
        let bus = UiEventBus()
        let clock = FixedClock(current: Date(timeIntervalSince1970: 1_780_000_000))
        let auth: AuthStore
        let settings: SettingsStore
        let catalog: BillerCatalogStore
        let billRepository: BillRepository
        let payments: PaymentsStore

        init(paymentNetwork: MockNetwork = MockNetwork(minDelayMs: 0, maxDelayMs: 0, failEvery: 1000)) {
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
                repository: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
                settingsStore: settings,
                clock: clock
            )
            billRepository = FakeBillRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0), clock: clock)
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
            await waitUntil { payments.userId != nil }
        }

        func awaitCatalog() async {
            await waitUntil { catalog.catalog.valueOrNull != nil }
        }

        func model(billerId: String, account: String, amountPaise: Int64?) -> BillReviewScreenModel {
            BillReviewScreenModel(
                catalogStore: catalog,
                billRepository: billRepository,
                paymentsStore: payments,
                dateStream: MidnightDateStream(clock: clock),
                clock: clock,
                billerId: billerId,
                account: account,
                amountPaise: amountPaise
            )
        }
    }

    @Test func openAmountReviewUsesPassedAmountWithoutFetch() async {
        let fixture = Fixture()
        await fixture.login()
        await fixture.awaitCatalog()
        let model = fixture.model(billerId: "dth-metro", account: "SUB99", amountPaise: 25050)
        model.start()
        await model.pendingWork?.value
        guard case let .review(_, _, _, _, customerName, dueInDays, amount, _, canPay) = model.data
        else { Issue.record("expected review"); return }
        #expect(amount == 25050)
        #expect(customerName == nil)
        #expect(dueInDays == nil)
        #expect(canPay)
    }

    @Test func presentmentReviewFetchesBillDetails() async {
        let fixture = Fixture()
        await fixture.login()
        await fixture.awaitCatalog()
        let model = fixture.model(billerId: "electricity-national", account: "12345", amountPaise: nil)
        model.start()
        await model.pendingWork?.value
        guard case let .review(_, _, _, _, customerName, _, amount, _, _) = model.data
        else { Issue.record("expected review"); return }
        #expect(amount > 0)
        #expect(customerName != nil)
    }

    @Test func openAmountWithoutAmountIsError() async {
        let fixture = Fixture()
        await fixture.login()
        await fixture.awaitCatalog()
        let model = fixture.model(billerId: "dth-metro", account: "SUB99", amountPaise: nil)
        model.start()
        await model.pendingWork?.value
        guard case .error = model.data else { Issue.record("expected error"); return }
    }

    @Test func payingDisablesPayButton() async {
        let fixture = Fixture(paymentNetwork: MockNetwork(minDelayMs: 100_000, maxDelayMs: 100_001, failEvery: 1000))
        await fixture.login()
        await fixture.awaitCatalog()
        let model = fixture.model(billerId: "dth-metro", account: "SUB99", amountPaise: 25050)
        model.start()
        await model.pendingWork?.value
        model.pay()
        guard case let .review(_, _, _, _, _, _, _, paying, canPay) = model.data
        else { Issue.record("expected review"); return }
        #expect(paying)
        #expect(!canPay)
    }
}

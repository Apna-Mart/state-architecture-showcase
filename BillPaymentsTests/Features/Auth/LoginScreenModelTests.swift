import Testing
@testable import BillPayments

struct LoginScreenModelTests {

    private func makeStore() -> AuthStore {
        AuthStore(
            authRepository: FakeAuthRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
            sessionRepository: StoredSessionRepository(store: InMemoryKeyValueStore()),
            events: UiEventBus()
        )
    }

    @Test func phoneEntryEnablesSendOnlyForTenDigitNumber() {
        let model = LoginScreenModel(authStore: makeStore())
        #expect(model.data == .phoneEntry(phone: "", canSend: false, sending: false))
        model.phone = "98765"
        #expect(model.data == .phoneEntry(phone: "98765", canSend: false, sending: false))
        model.phone = "9876543210"
        #expect(model.data == .phoneEntry(phone: "9876543210", canSend: true, sending: false))
        model.phone = "98765432ab"
        #expect(model.data == .phoneEntry(phone: "98765432ab", canSend: false, sending: false))
    }

    @Test func sendOtpProjectsSendingThenOtpEntry() async {
        let store = makeStore()
        let model = LoginScreenModel(authStore: store)
        model.phone = "9876543210"
        model.sendOtp()
        #expect(model.data == .phoneEntry(phone: "9876543210", canSend: false, sending: true))
        await store.pendingWork?.value
        #expect(model.data == .otpEntry(phone: "9876543210", otp: "", canVerify: false, verifying: false))
        model.otp = "123456"
        #expect(model.data == .otpEntry(phone: "9876543210", otp: "123456", canVerify: true, verifying: false))
    }

    @Test func changeNumberKeepsPhoneTextAndValidationConsistent() async {
        let store = makeStore()
        let model = LoginScreenModel(authStore: store)
        model.phone = "9876543210"
        model.sendOtp()
        await store.pendingWork?.value
        model.otp = "123456"
        model.changeNumber()
        await store.pendingWork?.value
        #expect(model.data == .phoneEntry(phone: "9876543210", canSend: true, sending: false))
    }

    @Test func screenDataRestoresInputsFromSavedState() {
        let model = LoginScreenModel(authStore: makeStore(), phone: "9876543210")
        #expect(model.data == .phoneEntry(phone: "9876543210", canSend: true, sending: false))
    }
}

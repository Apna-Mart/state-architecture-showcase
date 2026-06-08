import Testing
@testable import BillPayments

struct AuthStoreTests {

    private func makeStore(
        keyValueStore: InMemoryKeyValueStore = InMemoryKeyValueStore(),
        bus: UiEventBus = UiEventBus()
    ) -> AuthStore {
        AuthStore(
            authRepository: FakeAuthRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
            sessionRepository: StoredSessionRepository(store: keyValueStore),
            events: bus
        )
    }

    @Test func startsUnauthenticatedWithoutSession() {
        #expect(makeStore().state == .unauthenticated)
    }

    @Test func fullOtpFlowAuthenticates() async {
        let auth = makeStore()
        auth.sendOtp(phone: "9876543210")
        #expect(auth.state == .sendingOtp(phone: "9876543210"))
        await auth.pendingWork?.value
        #expect(auth.state == .otpSent(phone: "9876543210"))
        auth.verifyOtp(code: "123456")
        #expect(auth.state == .verifying(phone: "9876543210"))
        await auth.pendingWork?.value
        #expect(auth.state == .authenticated(userId: "user-9876543210", phone: "9876543210"))
    }

    @Test func sendOtpIgnoredWhileSending() {
        let auth = makeStore()
        auth.sendOtp(phone: "9876543210")
        auth.sendOtp(phone: "1111111111")
        #expect(auth.state == .sendingOtp(phone: "9876543210"))
    }

    @Test func verifyOtpIgnoredUnlessOtpSent() {
        let auth = makeStore()
        auth.verifyOtp(code: "123456")
        #expect(auth.state == .unauthenticated)
    }

    @Test func invalidOtpReturnsToOtpSentAndEmitsOtpRejected() async {
        let bus = UiEventBus()
        let auth = makeStore(bus: bus)
        var iterator = bus.events.makeAsyncIterator()
        auth.sendOtp(phone: "9876543210")
        await auth.pendingWork?.value
        auth.verifyOtp(code: "12")
        await auth.pendingWork?.value
        #expect(auth.state == .otpSent(phone: "9876543210"))
        let event = await iterator.next()
        #expect(event == .otpRejected)
    }

    @Test func sessionRestoredByFreshStoreGraph() async {
        let keyValueStore = InMemoryKeyValueStore()
        let first = makeStore(keyValueStore: keyValueStore)
        first.sendOtp(phone: "9876543210")
        await first.pendingWork?.value
        first.verifyOtp(code: "123456")
        await first.pendingWork?.value
        let second = makeStore(keyValueStore: keyValueStore)
        #expect(second.state == .authenticated(userId: "user-9876543210", phone: "9876543210"))
    }

    @Test func logoutClearsSession() async {
        let keyValueStore = InMemoryKeyValueStore()
        let auth = makeStore(keyValueStore: keyValueStore)
        auth.sendOtp(phone: "9876543210")
        await auth.pendingWork?.value
        auth.verifyOtp(code: "123456")
        await auth.pendingWork?.value
        auth.logout()
        await auth.pendingWork?.value
        #expect(auth.state == .unauthenticated)
        #expect(StoredSessionRepository(store: keyValueStore).restore() == nil)
    }
}

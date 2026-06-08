import Testing
@testable import BillPayments

@MainActor
struct SavedBillersStoreTests {

    private let biller = SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home")

    private func authedStore(
        keyValueStore: InMemoryKeyValueStore,
        bus: UiEventBus
    ) async -> AuthStore {
        let auth = AuthStore(
            authRepository: FakeAuthRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
            sessionRepository: StoredSessionRepository(store: keyValueStore),
            events: bus
        )
        auth.sendOtp(phone: "9876543210")
        await auth.pendingWork?.value
        auth.verifyOtp(code: "123456")
        await auth.pendingWork?.value
        return auth
    }

    private func awaitLogoutReaction(_ store: SavedBillersStore) async {
        await waitUntil { store.userId == nil }
    }

    @Test func saveAddsAndPersistsPerUser() async {
        let keyValueStore = InMemoryKeyValueStore()
        let bus = UiEventBus()
        let auth = await authedStore(keyValueStore: keyValueStore, bus: bus)
        let store = SavedBillersStore(
            authStore: auth,
            repository: StoredSavedBillersRepository(store: keyValueStore),
            events: bus
        )
        store.save(biller)
        await store.pendingWork?.value
        #expect(store.state.items == [biller])
        let restored = StoredSavedBillersRepository(store: keyValueStore).restore(userId: "user-9876543210")
        #expect(restored.items == [biller])
    }

    @Test func duplicateSaveIgnored() async {
        let keyValueStore = InMemoryKeyValueStore()
        let bus = UiEventBus()
        let auth = await authedStore(keyValueStore: keyValueStore, bus: bus)
        let store = SavedBillersStore(
            authStore: auth,
            repository: StoredSavedBillersRepository(store: keyValueStore),
            events: bus
        )
        store.save(biller)
        await store.pendingWork?.value
        store.save(SavedBiller(billerId: biller.billerId, account: biller.account, nickname: "Other"))
        await store.pendingWork?.value
        #expect(store.state.items.count == 1)
    }

    @Test func persistFailureRollsBackAndEmitsStorageFailed() async {
        let keyValueStore = InMemoryKeyValueStore()
        let bus = UiEventBus()
        let auth = await authedStore(keyValueStore: keyValueStore, bus: bus)
        let store = SavedBillersStore(
            authStore: auth,
            repository: StoredSavedBillersRepository(store: keyValueStore),
            events: bus
        )
        var iterator = bus.events.makeAsyncIterator()
        keyValueStore.failWrites = true
        store.save(biller)
        #expect(store.state.items == [biller])
        await store.pendingWork?.value
        #expect(store.state.items == [])
        let event = await iterator.next()
        #expect(event == .storageFailed)
    }

    @Test func logoutResetsToEmpty() async {
        let keyValueStore = InMemoryKeyValueStore()
        let bus = UiEventBus()
        let auth = await authedStore(keyValueStore: keyValueStore, bus: bus)
        let store = SavedBillersStore(
            authStore: auth,
            repository: StoredSavedBillersRepository(store: keyValueStore),
            events: bus
        )
        store.save(biller)
        await store.pendingWork?.value
        auth.logout()
        await auth.pendingWork?.value
        await awaitLogoutReaction(store)
        #expect(store.state == .empty)
    }
}

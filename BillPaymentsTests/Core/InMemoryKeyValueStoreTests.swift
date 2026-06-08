import Testing
@testable import BillPayments

struct InMemoryKeyValueStoreTests {

    @Test func readsBackWrittenValue() async throws {
        let store = InMemoryKeyValueStore()
        try await store.write("k", "v")
        #expect(store.read("k") == "v")
    }

    @Test func readReturnsNullForMissingKey() {
        #expect(InMemoryKeyValueStore().read("missing") == nil)
    }

    @Test func removeDeletesKey() async throws {
        let store = InMemoryKeyValueStore()
        try await store.write("k", "v")
        try await store.remove("k")
        #expect(store.read("k") == nil)
    }

    @Test func failWritesThrowsStorageError() async {
        let store = InMemoryKeyValueStore()
        store.failWrites = true
        await #expect(throws: StorageError.self) {
            try await store.write("k", "v")
        }
    }
}

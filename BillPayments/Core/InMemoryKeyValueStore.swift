final class InMemoryKeyValueStore: KeyValueStore {
    var failWrites = false
    private(set) var values: [String: String] = [:]

    func read(_ key: String) -> String? { values[key] }

    func write(_ key: String, _ value: String) async throws {
        if failWrites { throw StorageError() }
        values[key] = value
    }

    func remove(_ key: String) async throws {
        values[key] = nil
    }
}

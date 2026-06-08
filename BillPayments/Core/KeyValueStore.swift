protocol KeyValueStore {
    func read(_ key: String) -> String?
    func write(_ key: String, _ value: String) async throws
    func remove(_ key: String) async throws
}

struct StorageError: Error {}

import Foundation

protocol SavedBillersRepository {
    func restore(userId: String) -> SavedBillers
    func persist(userId: String, value: SavedBillers) async throws
}

final class StoredSavedBillersRepository: SavedBillersRepository {
    private let store: KeyValueStore

    init(store: KeyValueStore) {
        self.store = store
    }

    func restore(userId: String) -> SavedBillers {
        guard let raw = store.read(keyFor(userId)),
              let data = raw.data(using: .utf8),
              let items = try? JSONDecoder().decode([SavedBiller].self, from: data)
        else { return .empty }
        return SavedBillers(items: items)
    }

    func persist(userId: String, value: SavedBillers) async throws {
        let data = try JSONEncoder().encode(value.items)
        guard let raw = String(data: data, encoding: .utf8) else { throw StorageError() }
        try await store.write(keyFor(userId), raw)
    }

    private func keyFor(_ userId: String) -> String { "savedBillers.\(userId)" }
}

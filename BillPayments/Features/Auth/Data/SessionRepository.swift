struct Session: Equatable {
    let userId: String
    let phone: String
}

protocol SessionRepository {
    func restore() -> Session?
    func save(userId: String, phone: String) async throws
    func clear() async throws
}

final class StoredSessionRepository: SessionRepository {
    private static let userIdKey = "session.userId"
    private static let phoneKey = "session.phone"

    private let store: KeyValueStore

    init(store: KeyValueStore) {
        self.store = store
    }

    func restore() -> Session? {
        guard let userId = store.read(Self.userIdKey),
              let phone = store.read(Self.phoneKey) else { return nil }
        return Session(userId: userId, phone: phone)
    }

    func save(userId: String, phone: String) async throws {
        try await store.write(Self.userIdKey, userId)
        try await store.write(Self.phoneKey, phone)
    }

    func clear() async throws {
        try await store.remove(Self.userIdKey)
        try await store.remove(Self.phoneKey)
    }
}

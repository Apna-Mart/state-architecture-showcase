import Foundation

final class UserDefaultsKeyValueStore: KeyValueStore {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) { self.defaults = defaults }

    func read(_ key: String) -> String? { defaults.string(forKey: key) }
    func write(_ key: String, _ value: String) async throws { defaults.set(value, forKey: key) }
    func remove(_ key: String) async throws { defaults.removeObject(forKey: key) }
}

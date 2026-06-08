protocol SettingsRepository {
    func restore() -> AppSettings
    func saveThemeMode(_ mode: AppThemeMode) async throws
}

final class StoredSettingsRepository: SettingsRepository {
    private static let themeModeKey = "settings.themeMode"

    private let store: KeyValueStore

    init(store: KeyValueStore) {
        self.store = store
    }

    func restore() -> AppSettings {
        let themeName = store.read(Self.themeModeKey)
        let themeMode = AppThemeMode.allCases.first { $0.rawValue == themeName } ?? .system
        return AppSettings(themeMode: themeMode)
    }

    func saveThemeMode(_ mode: AppThemeMode) async throws {
        try await store.write(Self.themeModeKey, mode.rawValue)
    }
}

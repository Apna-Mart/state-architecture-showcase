import Observation

@Observable
final class SettingsScreenModel {
    @ObservationIgnored private let settingsStore: SettingsStore

    init(settingsStore: SettingsStore) {
        self.settingsStore = settingsStore
    }

    var themeMode: AppThemeMode { settingsStore.state.themeMode }

    var selectedLanguage: String? { settingsStore.languageOverride }

    func setThemeMode(_ mode: AppThemeMode) {
        settingsStore.setThemeMode(mode)
    }

    func applyLanguage(_ code: String?) {
        settingsStore.applyLanguage(code)
    }
}

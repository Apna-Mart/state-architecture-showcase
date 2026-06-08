import Foundation
import Observation

@Observable
final class SettingsStore {
    private(set) var state: AppSettings
    private(set) var language: String
    private(set) var languageOverride: String?
    @ObservationIgnored private(set) var pendingWork: Task<Void, Never>?

    @ObservationIgnored private let repository: SettingsRepository
    @ObservationIgnored private let systemLanguage: () -> String
    @ObservationIgnored private let readLanguageOverride: () -> String?
    @ObservationIgnored private let writeLanguageOverride: (String?) -> Void

    init(
        repository: SettingsRepository,
        systemLanguage: @escaping () -> String,
        readLanguageOverride: @escaping () -> String?,
        writeLanguageOverride: @escaping (String?) -> Void
    ) {
        self.repository = repository
        self.systemLanguage = systemLanguage
        self.readLanguageOverride = readLanguageOverride
        self.writeLanguageOverride = writeLanguageOverride
        self.state = repository.restore()
        let override = readLanguageOverride()
        self.languageOverride = override
        self.language = Self.resolveLanguage(override: override, systemLanguage: systemLanguage)
        L10n.setLanguage(language)
    }

    func refreshLanguage() {
        let override = readLanguageOverride()
        if override != languageOverride { languageOverride = override }
        let next = Self.resolveLanguage(override: override, systemLanguage: systemLanguage)
        guard next != language else { return }
        language = next
        L10n.setLanguage(next)
    }

    func applyLanguage(_ code: String?) {
        writeLanguageOverride(code)
        refreshLanguage()
    }

    func setThemeMode(_ mode: AppThemeMode) {
        guard mode != state.themeMode else { return }
        state = AppSettings(themeMode: mode)
        pendingWork = Task { try? await repository.saveThemeMode(mode) }
    }

    static func readAppleLanguagesOverride() -> String? {
        guard
            let bundleId = Bundle.main.bundleIdentifier,
            let override = UserDefaults.standard.persistentDomain(forName: bundleId)?["AppleLanguages"] as? [String]
        else { return nil }
        return override.first.map { String($0.prefix(2)) }
    }

    static func writeAppleLanguagesOverride(_ code: String?) {
        if let code {
            UserDefaults.standard.set([code], forKey: "AppleLanguages")
        } else {
            UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        }
    }

    private static func resolveLanguage(override: String?, systemLanguage: () -> String) -> String {
        let candidate = override ?? systemLanguage()
        return localeConfigs[candidate] != nil ? candidate : "en"
    }
}

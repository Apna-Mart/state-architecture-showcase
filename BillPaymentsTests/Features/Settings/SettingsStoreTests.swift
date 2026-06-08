import Testing
@testable import BillPayments

struct SettingsStoreTests {

    private func makeStore(
        keyValueStore: InMemoryKeyValueStore = InMemoryKeyValueStore(),
        systemLanguage: @escaping () -> String = { "en" },
        readLanguageOverride: @escaping () -> String? = { nil },
        writeLanguageOverride: @escaping (String?) -> Void = { _ in }
    ) -> SettingsStore {
        SettingsStore(
            repository: StoredSettingsRepository(store: keyValueStore),
            systemLanguage: systemLanguage,
            readLanguageOverride: readLanguageOverride,
            writeLanguageOverride: writeLanguageOverride
        )
    }

    @Test func defaultsToSystemTheme() {
        #expect(makeStore().state.themeMode == .system)
    }

    @Test func persistsAndRestoresTheme() async {
        let keyValueStore = InMemoryKeyValueStore()
        let first = makeStore(keyValueStore: keyValueStore)
        first.setThemeMode(.dark)
        await first.pendingWork?.value
        let second = makeStore(keyValueStore: keyValueStore)
        #expect(second.state.themeMode == .dark)
    }

    @Test func languageFollowsSystemElseEnglish() {
        let arabicSystem = makeStore(systemLanguage: { "ar" })
        #expect(arabicSystem.language == "ar")
        let frenchSystem = makeStore(systemLanguage: { "fr" })
        #expect(frenchSystem.language == "en")
    }

    @Test func refreshLanguagePicksUpLocaleChange() {
        var systemLanguage = "en"
        let store = makeStore(systemLanguage: { systemLanguage })
        #expect(store.language == "en")
        systemLanguage = "hi"
        store.refreshLanguage()
        #expect(store.language == "hi")
    }

    @Test func applyLanguageWritesOverrideAndResolves() {
        var stored: String?
        let store = makeStore(
            systemLanguage: { "en" },
            readLanguageOverride: { stored },
            writeLanguageOverride: { stored = $0 }
        )
        store.applyLanguage("hi")
        #expect(store.language == "hi")
        #expect(store.languageOverride == "hi")
        store.applyLanguage(nil)
        #expect(store.language == "en")
        #expect(store.languageOverride == nil)
    }
}

import SwiftUI

struct SettingsScreen: View {
    let container: AppContainer
    @State private var model: SettingsScreenModel

    init(container: AppContainer) {
        self.container = container
        _model = State(initialValue: SettingsScreenModel(settingsStore: container.settingsStore))
    }

    private static let languageOptions: [(code: String?, label: String)] = [
        (nil, ""),
        ("en", "English"),
        ("hi", "हिन्दी"),
        ("ar", "العربية"),
    ]

    var body: some View {
        List {
            Section(L10n.string("language")) {
                ForEach(Self.languageOptions, id: \.code) { option in
                    OptionRow(
                        label: option.code == nil ? L10n.string("system_default") : option.label,
                        selected: model.selectedLanguage == option.code,
                        onSelect: { model.applyLanguage(option.code) }
                    )
                }
            }
            Section(L10n.string("theme")) {
                ForEach(AppThemeMode.allCases, id: \.self) { mode in
                    OptionRow(
                        label: Self.themeLabel(mode),
                        selected: model.themeMode == mode,
                        onSelect: { model.setThemeMode(mode) }
                    )
                }
            }
        }
        .navigationTitle(L10n.string("settings"))
        .navigationBarTitleDisplayMode(.inline)
    }

    private static func themeLabel(_ mode: AppThemeMode) -> String {
        switch mode {
        case .system: L10n.string("system_default")
        case .light: L10n.string("theme_light")
        case .dark: L10n.string("theme_dark")
        }
    }
}

private struct OptionRow: View {
    let label: String
    let selected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                Image(systemName: selected ? "largecircle.fill.circle" : "circle")
                    .foregroundStyle(selected ? Color.primary : Color.secondary)
                Text(label)
                    .foregroundStyle(.primary)
            }
        }
    }
}

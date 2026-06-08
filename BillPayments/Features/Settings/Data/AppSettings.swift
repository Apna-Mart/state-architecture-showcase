enum AppThemeMode: String, CaseIterable, Equatable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}

struct AppSettings: Equatable {
    let themeMode: AppThemeMode
}

import Foundation

struct LocaleConfig: Equatable {
    let numberLocale: String
    let dateLocale: String
    let currencySymbol: String
}

let localeConfigs: [String: LocaleConfig] = [
    "en": LocaleConfig(numberLocale: "en-IN", dateLocale: "en", currencySymbol: "₹"),
    "hi": LocaleConfig(numberLocale: "hi", dateLocale: "hi", currencySymbol: "₹"),
    "ar": LocaleConfig(numberLocale: "ar-EG", dateLocale: "ar-EG", currencySymbol: "₹"),
]

func configFor(_ language: String) -> LocaleConfig {
    localeConfigs[language] ?? localeConfigs["en"]!
}

struct CalendarDate: Equatable {
    let year: Int
    let month: Int
    let day: Int

    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
}

private let gregorian: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    return calendar
}()

private func dateComponents(_ date: CalendarDate) -> DateComponents {
    DateComponents(year: date.year, month: date.month, day: date.day)
}

func formatPaise(_ paise: Int64, language: String) -> String {
    let config = configFor(language)
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: config.numberLocale)
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    let amount = NSNumber(value: Double(paise) / 100.0)
    let formatted = formatter.string(from: amount) ?? ""
    return "\(config.currencySymbol)\(formatted)"
}

func formatDate(_ date: CalendarDate, language: String) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: configFor(language).dateLocale)
    formatter.calendar = gregorian
    formatter.timeZone = gregorian.timeZone
    formatter.dateFormat = "d MMM yyyy"
    let resolved = gregorian.date(from: dateComponents(date)) ?? Date()
    return formatter.string(from: resolved)
}

func daysUntilDue(due: CalendarDate, today: CalendarDate) -> Int {
    let components = gregorian.dateComponents([.day], from: dateComponents(today), to: dateComponents(due))
    return components.day ?? 0
}

import Testing
@testable import BillPayments

struct FormatsTests {

    @Test func formatsPaiseAsIndianGroupedRupeesForEnglish() {
        let formatted = formatPaise(12345678, language: "en")
        #expect(formatted.hasPrefix("₹"))
        #expect(formatted.hasSuffix("456.78"))
        #expect(formatted.contains(","))
    }

    @Test func formatsPaiseWithTwoDecimals() {
        #expect(formatPaise(50000, language: "en") == "₹500.00")
    }

    @Test func unknownLanguageFallsBackToEnglish() {
        #expect(formatPaise(50000, language: "xx") == formatPaise(50000, language: "en"))
    }

    @Test func arabicUsesArabicDigits() {
        let formatted = formatPaise(50000, language: "ar")
        #expect(formatted.contains("٥"))
    }

    @Test func daysUntilDueIgnoresTimeOfDay() {
        #expect(daysUntilDue(
            due: CalendarDate(year: 2026, month: 6, day: 10),
            today: CalendarDate(year: 2026, month: 6, day: 7)
        ) == 3)
        #expect(daysUntilDue(
            due: CalendarDate(year: 2026, month: 6, day: 5),
            today: CalendarDate(year: 2026, month: 6, day: 7)
        ) == -2)
    }
}

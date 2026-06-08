import Foundation
import Testing
@testable import BillPayments

struct L10nGuardTests {

    private static let requiredLanguages = ["en", "hi", "ar"]

    private struct Catalog: Decodable {
        let strings: [String: Entry]
    }

    private struct Entry: Decodable {
        let localizations: [String: Localization]
    }

    private struct Localization: Decodable {
        let stringUnit: StringUnit?
        let variations: Variations?
    }

    private struct Variations: Decodable {
        let plural: [String: PluralCase]
    }

    private struct PluralCase: Decodable {
        let stringUnit: StringUnit
    }

    private struct StringUnit: Decodable {
        let value: String
    }

    private func loadCatalog() throws -> Catalog {
        let testFile = URL(fileURLWithPath: #filePath)
        let repoRoot = testFile
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let catalogURL = repoRoot
            .appendingPathComponent("BillPayments")
            .appendingPathComponent("Resources")
            .appendingPathComponent("Localizable.xcstrings")
        let data = try Data(contentsOf: catalogURL)
        return try JSONDecoder().decode(Catalog.self, from: data)
    }

    private func hasNonEmptyValue(_ localization: Localization) -> Bool {
        if let unit = localization.stringUnit { return !unit.value.isEmpty }
        guard let plural = localization.variations?.plural, !plural.isEmpty else { return false }
        return plural.values.allSatisfy { !$0.stringUnit.value.isEmpty }
    }

    @Test func allLocalesDefineEveryKeyWithNonEmptyValues() throws {
        let catalog = try loadCatalog()
        #expect(!catalog.strings.isEmpty)
        for (key, entry) in catalog.strings {
            for language in Self.requiredLanguages {
                let localization = entry.localizations[language]
                #expect(localization != nil, "\(key) missing language \(language)")
                if let localization {
                    #expect(hasNonEmptyValue(localization), "\(key) empty value for \(language)")
                }
            }
        }
    }

    @Test func containsAppTitleKey() throws {
        let catalog = try loadCatalog()
        #expect(catalog.strings["app_title"] != nil)
    }
}

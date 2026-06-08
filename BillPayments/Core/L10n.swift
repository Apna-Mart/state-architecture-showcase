import Foundation
import Observation

@Observable
final class L10n {
    static let shared = L10n()

    private(set) var bundle: Bundle = .main

    static func setLanguage(_ code: String) {
        shared.bundle = Bundle.main.path(forResource: code, ofType: "lproj")
            .flatMap(Bundle.init(path:)) ?? .main
    }

    static func string(_ key: String) -> String {
        shared.bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}

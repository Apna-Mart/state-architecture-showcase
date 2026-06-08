protocol BillerRepository {
    func fetchCatalog(language: String) async throws -> BillerCatalog
    func search(query: String, language: String) async throws -> [Biller]
}

final class FakeBillerRepository: BillerRepository {
    private static let openAmountCategories: Set<String> = ["mobile-prepaid", "dth", "fastag"]
    private static let prefixIds: [String] = ["national", "metro", "city", "state"]

    private let network: MockNetwork
    private var catalogs: [String: BillerCatalog] = [:]

    init(network: MockNetwork) {
        self.network = network
    }

    func fetchCatalog(language: String) async throws -> BillerCatalog {
        try await network.delay()
        return catalogFor(language)
    }

    func search(query: String, language: String) async throws -> [Biller] {
        try await network.delay()
        let needle = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return catalogFor(language).billers.filter { $0.name.lowercased().contains(needle) }
    }

    private func catalogFor(_ language: String) -> BillerCatalog {
        if let cached = catalogs[language] { return cached }
        let built = Self.buildCatalog(language: language)
        catalogs[language] = built
        return built
    }

    private static func buildCatalog(language: String) -> BillerCatalog {
        let categories = categoryOrder.map { id in
            BillerCategory(id: id, name: categoryNames[id]![language]!)
        }
        let billers = categoryOrder.flatMap { categoryId in
            prefixIds.map { prefixId in
                Biller(
                    id: "\(categoryId)-\(prefixId)",
                    categoryId: categoryId,
                    name: billerName(prefixId: prefixId, categoryId: categoryId, language: language),
                    mode: openAmountCategories.contains(categoryId) ? .openAmount : .presentment,
                    inputParams: paramsFor(categoryId: categoryId, language: language)
                )
            }
        }
        return BillerCatalog(categories: categories, billers: billers)
    }

    private static func paramsFor(categoryId: String, language: String) -> [BillerInputParam] {
        if categoryId == "credit-card" {
            return [
                BillerInputParam(
                    key: "card",
                    label: paramLabels["Card Number"]![language]!,
                    hint: paramHints["Last 4 digits"]![language]!
                ),
                BillerInputParam(
                    key: "mobile",
                    label: paramLabels["Registered Mobile"]![language]!,
                    hint: paramHints["10-digit mobile"]![language]!
                ),
            ]
        }
        let labelKey: String
        switch categoryId {
        case "mobile-postpaid", "mobile-prepaid": labelKey = "Mobile Number"
        case "dth": labelKey = "Subscriber ID"
        case "fastag": labelKey = "Vehicle Number"
        case "lpg": labelKey = "LPG ID"
        case "insurance": labelKey = "Policy Number"
        case "loan-emi": labelKey = "Loan Account Number"
        case "education": labelKey = "Student ID"
        default: labelKey = "Consumer Number"
        }
        let label = paramLabels[labelKey]![language]!
        return [BillerInputParam(key: "account", label: label, hint: enterHint(label: label, language: language))]
    }
}

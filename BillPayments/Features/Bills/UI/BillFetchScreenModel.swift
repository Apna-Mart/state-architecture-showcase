import Foundation
import Observation

@Observable
final class BillFetchScreenModel {
    @ObservationIgnored private let catalogStore: BillerCatalogStore
    @ObservationIgnored private let billerId: String

    var values: [String: String] = [:]
    var amountText = ""

    init(catalogStore: BillerCatalogStore, billerId: String) {
        self.catalogStore = catalogStore
        self.billerId = billerId
    }

    var data: BillFetchScreenData {
        if let catalog = catalogStore.catalog.valueOrNull {
            guard let biller = catalog.billerById(billerId) else {
                return .error(message: "Biller not found")
            }
            return formData(biller)
        }
        if case let .error(error) = catalogStore.catalog {
            return .error(message: String(describing: error))
        }
        return .loading
    }

    func editField(key: String, value: String) {
        values[key] = value
    }

    func editAmount(_ value: String) {
        amountText = value
    }

    private func formData(_ biller: Biller) -> BillFetchScreenData {
        let openAmount = biller.mode == .openAmount
        let fieldsFilled = biller.inputParams.allSatisfy { !valueOf($0.key).trimmed.isEmpty }
        let amountValid = !openAmount || amountPaise != nil
        let canSubmit = fieldsFilled && amountValid
        return .form(
            billerName: biller.name,
            inputs: FetchInputsData(
                fields: biller.inputParams.map {
                    FetchFieldData(key: $0.key, label: $0.label, hint: $0.hint, value: valueOf($0.key))
                },
                showAmount: openAmount,
                amountText: amountText
            ),
            submit: FetchSubmitData(
                action: openAmount ? .continueToReview : .fetchBill,
                reviewRoute: canSubmit ? reviewRoute(biller, openAmount: openAmount) : nil
            )
        )
    }

    private func reviewRoute(_ biller: Biller, openAmount: Bool) -> Route {
        .billReview(
            billerId: biller.id,
            account: biller.inputParams.map { valueOf($0.key).trimmed }.joined(separator: "|"),
            amountPaise: openAmount ? amountPaise : nil
        )
    }

    private func valueOf(_ key: String) -> String {
        values[key] ?? ""
    }

    private var amountPaise: Int64? {
        guard let rupees = Double(amountText), rupees > 0 else { return nil }
        return Int64((rupees * 100).rounded())
    }
}

private extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
}

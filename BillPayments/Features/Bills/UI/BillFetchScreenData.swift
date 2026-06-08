struct FetchFieldData: Equatable {
    let key: String
    let label: String
    let hint: String
    let value: String
}

struct FetchInputsData: Equatable {
    let fields: [FetchFieldData]
    let showAmount: Bool
    let amountText: String
}

enum FetchSubmitAction: Equatable {
    case fetchBill
    case continueToReview
}

struct FetchSubmitData: Equatable {
    let action: FetchSubmitAction
    let reviewRoute: Route?
}

enum BillFetchScreenData: Equatable {
    case loading
    case error(message: String)
    case form(billerName: String, inputs: FetchInputsData, submit: FetchSubmitData)
}

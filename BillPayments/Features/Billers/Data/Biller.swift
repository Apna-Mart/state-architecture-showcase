enum BillerMode: Equatable {
    case presentment
    case openAmount
}

struct BillerCategory: Equatable {
    let id: String
    let name: String
}

struct BillerInputParam: Equatable {
    let key: String
    let label: String
    let hint: String
}

struct Biller: Equatable {
    let id: String
    let categoryId: String
    let name: String
    let mode: BillerMode
    let inputParams: [BillerInputParam]
}

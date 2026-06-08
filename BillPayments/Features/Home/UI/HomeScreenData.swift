struct CategoryItemData: Equatable, Identifiable {
    let id: String
    let name: String
}

struct DueBillItemData: Equatable, Identifiable {
    let billerId: String
    let account: String
    let billerName: String
    let amountPaise: Int64
    let dueInDays: Int

    var id: String { "\(billerId):\(account)" }
}

struct SavedBillerItemData: Equatable, Identifiable {
    let billerId: String
    let account: String
    let nickname: String
    let billerName: String
    let openAmount: Bool

    var id: String { "\(billerId):\(account)" }
}

enum HomeRemindersData: Equatable {
    case loading
    case loaded([DueBillItemData])
}

enum HomeSavedBillersData: Equatable {
    case loading
    case loaded([SavedBillerItemData])
}

enum HomeCategoriesData: Equatable {
    case loading
    case error(String)
    case loaded([CategoryItemData])
}

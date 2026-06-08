import Foundation

struct PaymentListItemData: Equatable, Identifiable {
    let id: String
    let billerName: String
    let account: String
    let amountPaise: Int64
    let paidAt: Date
    let status: PaymentStatus
}

enum HistoryScreenData: Equatable {
    case empty
    case loaded(items: [PaymentListItemData])
}

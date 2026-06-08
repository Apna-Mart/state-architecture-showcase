import Foundation

enum ReceiptScreenData: Equatable {
    case notFound
    case processing(billerName: String, amountPaise: Int64)
    case success(
        paymentId: String,
        billerId: String,
        billerName: String,
        account: String,
        amountPaise: Int64,
        paidAt: Date,
        canSaveBiller: Bool
    )
    case failed(
        billerId: String,
        billerName: String,
        categoryId: String,
        account: String,
        amountPaise: Int64
    )
}

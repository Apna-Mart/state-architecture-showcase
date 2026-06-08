enum BillReviewScreenData: Equatable {
    case loading
    case error(message: String)
    case review(
        billerId: String,
        categoryId: String,
        billerName: String,
        account: String,
        customerName: String?,
        dueInDays: Int?,
        amountPaise: Int64,
        paying: Bool,
        canPay: Bool
    )
}

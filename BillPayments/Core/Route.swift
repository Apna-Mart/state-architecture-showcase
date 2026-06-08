enum Route: Hashable, Codable {
    case login
    case home
    case search
    case history
    case settings
    case category(categoryId: String)
    case billFetch(billerId: String)
    case billReview(billerId: String, account: String, amountPaise: Int64?)
    case receipt(paymentId: String)
}

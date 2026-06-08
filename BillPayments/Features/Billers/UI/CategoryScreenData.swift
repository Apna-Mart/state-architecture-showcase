enum CategoryScreenData: Equatable {
    case loading
    case error(String)
    case loaded(categoryName: String, billers: [BillerListItemData])
}

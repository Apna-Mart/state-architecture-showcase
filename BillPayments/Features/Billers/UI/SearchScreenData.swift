enum SearchScreenData: Equatable {
    case idle
    case searching
    case empty(query: String)
    case error(query: String)
    case results([BillerListItemData])
}

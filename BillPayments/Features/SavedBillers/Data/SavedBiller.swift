struct SavedBiller: Codable, Equatable {
    let billerId: String
    let account: String
    let nickname: String
}

struct SavedBillers: Equatable {
    let items: [SavedBiller]

    func contains(billerId: String, account: String) -> Bool {
        items.contains { $0.billerId == billerId && $0.account == account }
    }

    func adding(_ saved: SavedBiller) -> SavedBillers {
        SavedBillers(items: items + [saved])
    }

    func removing(billerId: String, account: String) -> SavedBillers {
        SavedBillers(items: items.filter { !($0.billerId == billerId && $0.account == account) })
    }

    static let empty = SavedBillers(items: [])
}

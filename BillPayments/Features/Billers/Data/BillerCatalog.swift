struct BillerCatalog: Equatable {
    let categories: [BillerCategory]
    let billers: [Biller]

    func billersFor(categoryId: String) -> [Biller] {
        billers.filter { $0.categoryId == categoryId }
    }

    func billerById(_ id: String) -> Biller? {
        billers.first { $0.id == id }
    }

    func categoryById(_ id: String) -> BillerCategory? {
        categories.first { $0.id == id }
    }
}

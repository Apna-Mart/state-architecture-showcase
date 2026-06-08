import Observation

@Observable
final class CategoryScreenModel {
    @ObservationIgnored private let catalogStore: BillerCatalogStore
    @ObservationIgnored let categoryId: String

    init(categoryId: String, catalogStore: BillerCatalogStore) {
        self.categoryId = categoryId
        self.catalogStore = catalogStore
    }

    var data: CategoryScreenData {
        if let catalog = catalogStore.catalog.valueOrNull {
            guard let category = catalog.categoryById(categoryId) else {
                return .error("Category not found")
            }
            let billers = catalog.billersFor(categoryId: categoryId).map {
                BillerListItemData(id: $0.id, name: $0.name, categoryName: category.name)
            }
            return .loaded(categoryName: category.name, billers: billers)
        }
        if case let .error(error) = catalogStore.catalog {
            return .error(String(describing: error))
        }
        return .loading
    }
}

import SwiftUI

struct CategoryScreen: View {
    let container: AppContainer
    @State private var model: CategoryScreenModel

    init(container: AppContainer, categoryId: String) {
        self.container = container
        _model = State(initialValue: CategoryScreenModel(
            categoryId: categoryId,
            catalogStore: container.catalogStore
        ))
    }

    var body: some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var content: some View {
        switch model.data {
        case .loading:
            ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error:
            Text(L10n.string("something_went_wrong")).frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .loaded(_, billers):
            List(billers) { biller in
                BillerListItem(data: biller)
            }
        }
    }

    private var title: String {
        if case let .loaded(categoryName, _) = model.data { return categoryName }
        return L10n.string("billers")
    }
}

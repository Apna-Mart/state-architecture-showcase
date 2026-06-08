import SwiftUI

struct SearchScreen: View {
    let container: AppContainer
    @State private var model: SearchScreenModel

    init(container: AppContainer) {
        self.container = container
        _model = State(initialValue: SearchScreenModel(
            repository: container.billerRepository,
            catalogStore: container.catalogStore,
            settingsStore: container.settingsStore
        ))
    }

    var body: some View {
        VStack(spacing: 16) {
            TextField(L10n.string("search_billers"), text: queryBinding)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .padding(.horizontal, 16)
            content
        }
        .padding(.top, 16)
        .navigationTitle(L10n.string("search_billers"))
        .navigationBarTitleDisplayMode(.inline)
        .task { await model.consumeLanguageChanges() }
    }

    private var queryBinding: Binding<String> {
        Binding(get: { model.query }, set: { model.editQuery($0) })
    }

    @ViewBuilder
    private var content: some View {
        switch model.data {
        case .idle:
            CenteredMessage(message: L10n.string("type_at_least_two_characters"))
        case .searching:
            ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .empty(query):
            CenteredMessage(message: String.localizedStringWithFormat(L10n.string("no_billers_match"), query))
        case .error:
            CenteredMessage(message: L10n.string("search_failed"))
        case let .results(billers):
            List(billers) { biller in
                BillerListItem(data: biller)
            }
        }
    }
}

private struct CenteredMessage: View {
    let message: String

    var body: some View {
        Text(message)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

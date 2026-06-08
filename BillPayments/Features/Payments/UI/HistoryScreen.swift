import SwiftUI

struct HistoryScreen: View {
    let container: AppContainer
    @State private var model: HistoryScreenModel

    init(container: AppContainer) {
        self.container = container
        _model = State(initialValue: HistoryScreenModel(paymentsStore: container.paymentsStore))
    }

    var body: some View {
        content
            .navigationTitle(L10n.string("payment_history"))
            .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var content: some View {
        switch model.data {
        case .empty:
            Text(L10n.string("no_payments_yet"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .loaded(items):
            List(items) { item in
                NavigationLink(value: Route.receipt(paymentId: item.id)) {
                    PaymentRowView(item: item, language: container.settingsStore.language)
                }
            }
        }
    }
}

private struct PaymentRowView: View {
    let item: PaymentListItemData
    let language: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(statusLabel)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(item.billerName)
                Text(String.localizedStringWithFormat(L10n.string("account_value"), item.account))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(formatPaise(item.amountPaise, language: language))
        }
    }

    private var statusLabel: String {
        switch item.status {
        case .processing: L10n.string("status_processing")
        case .success: L10n.string("status_success")
        case .failed: L10n.string("status_failed")
        }
    }
}

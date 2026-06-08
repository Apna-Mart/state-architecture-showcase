import SwiftUI

struct BillReviewScreen: View {
    let container: AppContainer
    let billerId: String
    let account: String
    let amountPaise: Int64?
    @State private var model: BillReviewScreenModel

    init(container: AppContainer, billerId: String, account: String, amountPaise: Int64?) {
        self.container = container
        self.billerId = billerId
        self.account = account
        self.amountPaise = amountPaise
        _model = State(initialValue: BillReviewScreenModel(
            catalogStore: container.catalogStore,
            billRepository: container.billRepository,
            paymentsStore: container.paymentsStore,
            dateStream: container.dateStream,
            clock: container.clock,
            billerId: billerId,
            account: account,
            amountPaise: amountPaise
        ))
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(L10n.string("review_and_pay"))
            .navigationBarTitleDisplayMode(.inline)
            .task {
                model.start()
                await model.consumeDates()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch model.data {
        case .loading:
            ProgressView()
        case .error:
            Text(L10n.string("something_went_wrong"))
        case let .review(_, _, billerName, account, customerName, dueInDays, amountPaise, paying, canPay):
            ReviewContentView(
                billerName: billerName,
                account: account,
                customerName: customerName,
                dueInDays: dueInDays,
                amountPaise: amountPaise,
                paying: paying,
                canPay: canPay,
                language: container.settingsStore.language,
                onPay: model.pay
            )
        }
    }
}

private struct ReviewContentView: View {
    let billerName: String
    let account: String
    let customerName: String?
    let dueInDays: Int?
    let amountPaise: Int64
    let paying: Bool
    let canPay: Bool
    let language: String
    let onPay: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(billerName)
                    .font(.title2)
                Text(String.localizedStringWithFormat(L10n.string("account_value"), account))
                if let customerName {
                    Text(String.localizedStringWithFormat(L10n.string("name_value"), customerName))
                }
                if let dueInDays {
                    Text(dueLabel(dueInDays))
                }
                Text(formatPaise(amountPaise, language: language))
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))

            Button(action: onPay) {
                if paying {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Text(String.localizedStringWithFormat(
                        L10n.string("pay_amount"),
                        formatPaise(amountPaise, language: language)
                    ))
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(!canPay)
            Spacer()
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    private func dueLabel(_ days: Int) -> String {
        if days == 0 { return L10n.string("due_today") }
        if days > 0 { return String.localizedStringWithFormat(L10n.string("due_in_days"), days) }
        return String.localizedStringWithFormat(L10n.string("overdue_by_days"), -days)
    }
}

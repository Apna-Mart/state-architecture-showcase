import SwiftUI

struct ReceiptScreen: View {
    let container: AppContainer
    let paymentId: String
    @State private var model: ReceiptScreenModel

    init(container: AppContainer, paymentId: String) {
        self.container = container
        self.paymentId = paymentId
        _model = State(initialValue: ReceiptScreenModel(
            paymentsStore: container.paymentsStore,
            savedBillersStore: container.savedBillersStore,
            paymentId: paymentId
        ))
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(L10n.string("payment"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
    }

    private var language: String { container.settingsStore.language }

    @ViewBuilder
    private var content: some View {
        switch model.data {
        case .notFound:
            Text(L10n.string("payment_not_found"))
        case let .processing(billerName, amountPaise):
            ProcessingContentView(billerName: billerName, amountPaise: amountPaise, language: language)
        case let .success(paymentId, _, billerName, account, amountPaise, paidAt, canSaveBiller):
            SuccessContentView(
                paymentId: paymentId,
                billerName: billerName,
                account: account,
                amountPaise: amountPaise,
                paidAt: paidAt,
                canSaveBiller: canSaveBiller,
                language: language,
                onSaveBiller: { model.saveBiller(nickname: billerName) },
                onDone: done
            )
        case let .failed(_, billerName, _, _, amountPaise):
            FailedContentView(
                billerName: billerName,
                amountPaise: amountPaise,
                language: language,
                onRetry: model.retryPayment,
                onDone: done
            )
        }
    }

    private func done() {
        container.router.reset(to: [])
    }
}

private struct ProcessingContentView: View {
    let billerName: String
    let amountPaise: Int64
    let language: String

    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text(String.localizedStringWithFormat(
                L10n.string("paying_amount_to"),
                formatPaise(amountPaise, language: language),
                billerName
            ))
        }
    }
}

private struct SuccessContentView: View {
    let paymentId: String
    let billerName: String
    let account: String
    let amountPaise: Int64
    let paidAt: Date
    let canSaveBiller: Bool
    let language: String
    let onSaveBiller: () -> Void
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(formatPaise(amountPaise, language: language))
                .font(.largeTitle)
            Text(String.localizedStringWithFormat(L10n.string("paid_to"), billerName))
            Text(String.localizedStringWithFormat(L10n.string("receipt_number"), paymentId))
            Text(String.localizedStringWithFormat(L10n.string("account_value"), account))
            Text(String.localizedStringWithFormat(
                L10n.string("date_value"),
                formatDate(calendarDate(paidAt), language: language)
            ))
            if canSaveBiller {
                Button(action: onSaveBiller) {
                    Text(L10n.string("save_biller"))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            Button(action: onDone) {
                Text(L10n.string("done"))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct FailedContentView: View {
    let billerName: String
    let amountPaise: Int64
    let language: String
    let onRetry: () -> Void
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(String.localizedStringWithFormat(
                L10n.string("payment_failed_summary"),
                formatPaise(amountPaise, language: language),
                billerName
            ))
            .font(.headline)
            Button(action: onRetry) {
                Text(L10n.string("retry_payment"))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            Button(action: onDone) {
                Text(L10n.string("back_to_home"))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private func calendarDate(_ date: Date) -> CalendarDate {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return CalendarDate(year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0)
}

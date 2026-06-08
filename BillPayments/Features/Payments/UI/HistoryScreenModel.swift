import Observation

@Observable
final class HistoryScreenModel {
    @ObservationIgnored private let paymentsStore: PaymentsStore

    init(paymentsStore: PaymentsStore) {
        self.paymentsStore = paymentsStore
    }

    var data: HistoryScreenData {
        let payments = paymentsStore.state
        if payments.items.isEmpty { return .empty }
        return .loaded(items: payments.items.reversed().map {
            PaymentListItemData(
                id: $0.id,
                billerName: $0.billerName,
                account: $0.account,
                amountPaise: $0.amountPaise,
                paidAt: $0.paidAtUtc,
                status: $0.status
            )
        })
    }
}

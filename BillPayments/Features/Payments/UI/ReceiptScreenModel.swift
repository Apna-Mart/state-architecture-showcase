import Observation

@Observable
final class ReceiptScreenModel {
    @ObservationIgnored private let paymentsStore: PaymentsStore
    @ObservationIgnored private let savedBillersStore: SavedBillersStore
    @ObservationIgnored private let paymentId: String

    init(paymentsStore: PaymentsStore, savedBillersStore: SavedBillersStore, paymentId: String) {
        self.paymentsStore = paymentsStore
        self.savedBillersStore = savedBillersStore
        self.paymentId = paymentId
    }

    var data: ReceiptScreenData {
        guard let payment = paymentsStore.state.byId(paymentId) else { return .notFound }
        switch payment.status {
        case .processing:
            return .processing(billerName: payment.billerName, amountPaise: payment.amountPaise)
        case .success:
            return .success(
                paymentId: payment.id,
                billerId: payment.billerId,
                billerName: payment.billerName,
                account: payment.account,
                amountPaise: payment.amountPaise,
                paidAt: payment.paidAtUtc,
                canSaveBiller: !savedBillersStore.state.contains(billerId: payment.billerId, account: payment.account)
            )
        case .failed:
            return .failed(
                billerId: payment.billerId,
                billerName: payment.billerName,
                categoryId: payment.categoryId,
                account: payment.account,
                amountPaise: payment.amountPaise
            )
        }
    }

    func saveBiller(nickname: String) {
        guard case let .success(_, billerId, _, account, _, _, _) = data else { return }
        savedBillersStore.save(SavedBiller(billerId: billerId, account: account, nickname: nickname))
    }

    func retryPayment() {
        guard case let .failed(billerId, billerName, categoryId, account, amountPaise) = data else { return }
        paymentsStore.pay(
            billerId: billerId,
            billerName: billerName,
            categoryId: categoryId,
            account: account,
            amountPaise: amountPaise
        )
    }
}

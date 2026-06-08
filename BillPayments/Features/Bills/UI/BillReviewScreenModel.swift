import Foundation
import Observation

@Observable
final class BillReviewScreenModel {
    @ObservationIgnored private let catalogStore: BillerCatalogStore
    @ObservationIgnored private let billRepository: BillRepository
    @ObservationIgnored private let paymentsStore: PaymentsStore
    @ObservationIgnored private let dateStream: DateStream
    @ObservationIgnored private let billerId: String
    @ObservationIgnored private let account: String
    @ObservationIgnored private let amountPaise: Int64?

    @ObservationIgnored private(set) var pendingWork: Task<Void, Never>?
    @ObservationIgnored private var didStart = false

    private var billState: Async<FetchedBill> = .loading(previous: nil)
    private var today: CalendarDate

    init(
        catalogStore: BillerCatalogStore,
        billRepository: BillRepository,
        paymentsStore: PaymentsStore,
        dateStream: DateStream,
        clock: Clock,
        billerId: String,
        account: String,
        amountPaise: Int64?
    ) {
        self.catalogStore = catalogStore
        self.billRepository = billRepository
        self.paymentsStore = paymentsStore
        self.dateStream = dateStream
        self.billerId = billerId
        self.account = account
        self.amountPaise = amountPaise
        self.today = Self.calendarDate(clock.now())
    }

    var data: BillReviewScreenData {
        let paying = paymentsStore.state.hasProcessing(billerId: billerId, account: account)
        if case let .error(error) = catalogStore.catalog {
            return .error(message: String(describing: error))
        }
        guard let catalog = catalogStore.catalog.valueOrNull else { return .loading }
        guard let biller = catalog.billerById(billerId) else {
            return .error(message: "Biller not found")
        }
        if biller.mode == .openAmount {
            guard let amount = amountPaise else { return .error(message: "Amount missing") }
            return review(biller, amount: amount, customerName: nil, dueInDays: nil, paying: paying)
        }
        switch billState {
        case let .data(bill):
            return review(
                biller,
                amount: bill.amountPaise,
                customerName: bill.customerName,
                dueInDays: daysUntilDue(due: bill.dueDate, today: today),
                paying: paying
            )
        case let .error(error):
            return .error(message: String(describing: error))
        case .loading:
            return .loading
        }
    }

    func start() {
        guard !didStart else { return }
        didStart = true
        loadBill()
    }

    func consumeDates() async {
        for await date in dateStream.dates() {
            today = Self.calendarDate(date)
        }
    }

    func pay() {
        guard case let .review(billerId, categoryId, billerName, account, _, _, amountPaise, _, canPay) = data, canPay
        else { return }
        paymentsStore.pay(
            billerId: billerId,
            billerName: billerName,
            categoryId: categoryId,
            account: account,
            amountPaise: amountPaise
        )
    }

    private func loadBill() {
        guard
            case let .data(catalog) = catalogStore.catalog,
            let biller = catalog.billerById(billerId),
            biller.mode == .presentment
        else { return }
        billState = .loading(previous: nil)
        pendingWork = Task { [weak self] in
            guard let self else { return }
            do {
                let bill = try await self.billRepository.fetchBill(billerId: self.billerId, account: self.account)
                if Task.isCancelled { return }
                self.billState = .data(bill)
            } catch {
                if Task.isCancelled { return }
                self.billState = .error(error)
            }
        }
    }

    private func review(
        _ biller: Biller,
        amount: Int64,
        customerName: String?,
        dueInDays: Int?,
        paying: Bool
    ) -> BillReviewScreenData {
        .review(
            billerId: biller.id,
            categoryId: biller.categoryId,
            billerName: biller.name,
            account: account,
            customerName: customerName,
            dueInDays: dueInDays,
            amountPaise: amount,
            paying: paying,
            canPay: !paying
        )
    }

    private static func calendarDate(_ date: Date) -> CalendarDate {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return CalendarDate(year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0)
    }
}

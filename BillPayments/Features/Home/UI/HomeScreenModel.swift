import Foundation
import Observation

@Observable
final class HomeScreenModel {
    @ObservationIgnored private let catalogStore: BillerCatalogStore
    @ObservationIgnored private let savedBillersStore: SavedBillersStore
    @ObservationIgnored private let dueBillsStore: DueBillsStore
    @ObservationIgnored private let dateStream: DateStream

    @ObservationIgnored private static let utcCalendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()

    private(set) var today: CalendarDate?

    init(
        catalogStore: BillerCatalogStore,
        savedBillersStore: SavedBillersStore,
        dueBillsStore: DueBillsStore,
        dateStream: DateStream
    ) {
        self.catalogStore = catalogStore
        self.savedBillersStore = savedBillersStore
        self.dueBillsStore = dueBillsStore
        self.dateStream = dateStream
    }

    var categoriesData: HomeCategoriesData {
        if let catalog = catalogStore.catalog.valueOrNull {
            return .loaded(catalog.categories.map { CategoryItemData(id: $0.id, name: $0.name) })
        }
        if case let .error(error) = catalogStore.catalog {
            return .error(String(describing: error))
        }
        return .loading
    }

    var savedBillersData: HomeSavedBillersData {
        let saved = savedBillersStore.state.items
        if saved.isEmpty { return .loaded([]) }
        if case .error = catalogStore.catalog { return .loaded([]) }
        guard let catalog = catalogStore.catalog.valueOrNull else { return .loading }
        let byId = Dictionary(uniqueKeysWithValues: catalog.billers.map { ($0.id, $0) })
        return .loaded(saved.map { item in
            let biller = byId[item.billerId]
            return SavedBillerItemData(
                billerId: item.billerId,
                account: item.account,
                nickname: item.nickname,
                billerName: biller?.name ?? item.billerId,
                openAmount: biller?.mode == .openAmount
            )
        })
    }

    var remindersData: HomeRemindersData {
        let saved = savedBillersStore.state.items
        if saved.isEmpty { return .loaded([]) }
        guard let today else { return .loading }
        if case .error = catalogStore.catalog { return .loaded([]) }
        guard let catalog = catalogStore.catalog.valueOrNull else { return .loading }
        if case .error = dueBillsStore.dueBills { return .loaded([]) }
        guard let bills = dueBillsStore.dueBills.valueOrNull else { return .loading }
        return .loaded(dueItems(catalog: catalog, bills: bills, today: today))
    }

    func consumeDates() async {
        for await date in dateStream.dates() {
            today = Self.calendarDate(from: date)
        }
    }

    private func dueItems(catalog: BillerCatalog, bills: [FetchedBill], today: CalendarDate) -> [DueBillItemData] {
        let byId = Dictionary(uniqueKeysWithValues: catalog.billers.map { ($0.id, $0) })
        return bills
            .filter { byId[$0.billerId]?.mode == .presentment }
            .map { bill in
                DueBillItemData(
                    billerId: bill.billerId,
                    account: bill.account,
                    billerName: byId[bill.billerId]?.name ?? bill.billerId,
                    amountPaise: bill.amountPaise,
                    dueInDays: daysUntilDue(due: bill.dueDate, today: today)
                )
            }
    }

    private static func calendarDate(from date: Date) -> CalendarDate {
        let components = utcCalendar.dateComponents([.year, .month, .day], from: date)
        return CalendarDate(year: components.year ?? 1970, month: components.month ?? 1, day: components.day ?? 1)
    }
}

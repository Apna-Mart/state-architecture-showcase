import Foundation

protocol BillRepository {
    func fetchBill(billerId: String, account: String) async throws -> FetchedBill
    func fetchDueBills(saved: [SavedBiller]) async throws -> [FetchedBill]
}

final class FakeBillRepository: BillRepository {
    private static let customers = [
        "Ramesh Kumar", "Priya Sharma", "Amit Patel", "Sunita Reddy", "Vikram Singh",
    ]

    private static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()

    private let network: MockNetwork
    private let clock: Clock

    init(network: MockNetwork, clock: Clock) {
        self.network = network
        self.clock = clock
    }

    func fetchBill(billerId: String, account: String) async throws -> FetchedBill {
        try await network.delay()
        return billFor(billerId: billerId, account: account)
    }

    func fetchDueBills(saved: [SavedBiller]) async throws -> [FetchedBill] {
        try await network.delay(times: 6)
        return saved.map { billFor(billerId: $0.billerId, account: $0.account) }
    }

    private func billFor(billerId: String, account: String) -> FetchedBill {
        let seed = Self.seedOf(billerId: billerId, account: account)
        let today = Self.calendar.startOfDay(for: clock.now())
        let due = Self.calendar.date(byAdding: .day, value: seed % 15 - 3, to: today)!
        let components = Self.calendar.dateComponents([.year, .month, .day], from: due)
        return FetchedBill(
            billerId: billerId,
            account: account,
            customerName: Self.customers[seed % Self.customers.count],
            amountPaise: Int64(seed % 4500 + 200) * 100,
            dueDate: CalendarDate(year: components.year!, month: components.month!, day: components.day!),
            billNumber: "BILL-\(String(seed, radix: 16, uppercase: true))-\(seed)"
        )
    }

    private static func seedOf(billerId: String, account: String) -> Int {
        "\(billerId)|\(account)".utf16.reduce(0) { $0 + Int($1) }
    }
}

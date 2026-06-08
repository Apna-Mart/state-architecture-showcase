import Foundation
import Testing
@testable import BillPayments

struct FakeBillRepositoryTests {

    private let clock = FixedClock(current: ISO8601DateFormatter().date(from: "2026-06-07T10:00:00Z")!)
    private var repository: FakeBillRepository {
        FakeBillRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0), clock: clock)
    }

    @Test func billIsDeterministicPerBillerAndAccount() async throws {
        let first = try await repository.fetchBill(billerId: "electricity-national", account: "12345")
        let second = try await repository.fetchBill(billerId: "electricity-national", account: "12345")
        #expect(first == second)
    }

    @Test func amountDerivedFromSeedWithinRange() async throws {
        let bill = try await repository.fetchBill(billerId: "electricity-national", account: "12345")
        #expect((20_000...470_000).contains(bill.amountPaise))
        #expect(bill.amountPaise % 100 == 0)
    }

    @Test func dueDateWithinMinus3ToPlus11DaysOfToday() async throws {
        let today = CalendarDate(year: 2026, month: 6, day: 7)
        let bill = try await repository.fetchBill(billerId: "water-metro", account: "999")
        let offset = daysUntilDue(due: bill.dueDate, today: today)
        #expect((-3...11).contains(offset))
    }

    @Test func fetchDueBillsReturnsOnePerSavedBiller() async throws {
        let saved = [
            SavedBiller(billerId: "electricity-national", account: "1", nickname: "A"),
            SavedBiller(billerId: "water-metro", account: "2", nickname: "B"),
        ]
        let result = try await repository.fetchDueBills(saved: saved)
        #expect(result.count == 2)
    }
}

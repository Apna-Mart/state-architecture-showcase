import Foundation
@testable import BillPayments

final class FixedClock: Clock {
    var current: Date

    init(current: Date = Date(timeIntervalSince1970: 1_700_000_000)) { self.current = current }

    func now() -> Date { current }

    func advance(by interval: TimeInterval) { current += interval }
}

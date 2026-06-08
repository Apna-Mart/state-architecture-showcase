import Testing
import Foundation
@testable import BillPayments

struct FreshnessTests {

    @Test func staleBeforeFirstFetch() {
        let freshness = Freshness(clock: FixedClock(), maxAge: 5 * 60)
        #expect(freshness.isStale())
    }

    @Test func freshWithinMaxAge() {
        let clock = FixedClock()
        let freshness = Freshness(clock: clock, maxAge: 5 * 60)
        freshness.markFetched()
        clock.advance(by: 4 * 60)
        #expect(!freshness.isStale())
    }

    @Test func staleAfterMaxAge() {
        let clock = FixedClock()
        let freshness = Freshness(clock: clock, maxAge: 5 * 60)
        freshness.markFetched()
        clock.advance(by: 6 * 60)
        #expect(freshness.isStale())
    }
}

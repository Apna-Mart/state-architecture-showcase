import Foundation

final class Freshness {
    private let clock: Clock
    private let maxAge: TimeInterval
    private var fetchedAt: Date?

    init(clock: Clock, maxAge: TimeInterval) {
        self.clock = clock
        self.maxAge = maxAge
    }

    func markFetched() { fetchedAt = clock.now() }

    func isStale() -> Bool {
        guard let fetchedAt else { return true }
        return clock.now().timeIntervalSince(fetchedAt) >= maxAge
    }
}

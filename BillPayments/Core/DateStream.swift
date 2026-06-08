import Foundation

protocol DateStream {
    func dates() -> AsyncStream<Date>
}

final class MidnightDateStream: DateStream {
    private let calendar: Calendar
    private let clock: Clock

    init(calendar: Calendar = .current, clock: Clock) {
        self.calendar = calendar
        self.clock = clock
    }

    func dates() -> AsyncStream<Date> {
        AsyncStream { continuation in
            let task = Task { @MainActor in
                while !Task.isCancelled {
                    let now = self.clock.now()
                    continuation.yield(self.calendar.startOfDay(for: now))
                    let nextMidnight = self.calendar.nextDate(
                        after: now,
                        matching: DateComponents(hour: 0, minute: 0, second: 0),
                        matchingPolicy: .nextTime
                    ) ?? now.addingTimeInterval(86_400)
                    try? await Task.sleep(for: .seconds(nextMidnight.timeIntervalSince(now)))
                }
                continuation.finish()
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }
}

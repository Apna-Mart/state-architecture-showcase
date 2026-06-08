import Foundation

struct MockPaymentDeclined: Error {}

struct SplitMix64: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) { state = seed }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}

final class MockNetwork {
    private let minDelayMs: Int
    private let maxDelayMs: Int
    private let failEvery: Int
    private var rng: SplitMix64
    private var failCounter = 0

    init(minDelayMs: Int = 300, maxDelayMs: Int = 800, failEvery: Int = 10, seed: UInt64 = 42) {
        self.minDelayMs = minDelayMs
        self.maxDelayMs = maxDelayMs
        self.failEvery = failEvery
        self.rng = SplitMix64(seed: seed)
    }

    func nextDelayMs() -> Int {
        minDelayMs + Int(rng.next() % UInt64(max(1, maxDelayMs - minDelayMs)))
    }

    func delay(times: Int = 1) async throws {
        try await Task.sleep(for: .milliseconds(nextDelayMs() * times))
    }

    func countAndMaybeFail() throws {
        failCounter += 1
        if failCounter % failEvery == 0 { throw MockPaymentDeclined() }
    }
}

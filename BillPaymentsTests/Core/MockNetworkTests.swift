import Testing
@testable import BillPayments

struct MockNetworkTests {

    @Test func nextDelayStaysWithinBounds() {
        let network = MockNetwork(minDelayMs: 300, maxDelayMs: 800)
        for _ in 0..<100 {
            let delay = network.nextDelayMs()
            #expect(delay >= 300)
            #expect(delay < 800)
        }
    }

    @Test func failsExactlyEveryNthCall() throws {
        let network = MockNetwork(failEvery: 3)
        try network.countAndMaybeFail()
        try network.countAndMaybeFail()
        #expect(throws: MockPaymentDeclined.self) {
            try network.countAndMaybeFail()
        }
        try network.countAndMaybeFail()
    }

    @Test func zeroDelayNetworkCompletesImmediately() async throws {
        let network = MockNetwork(minDelayMs: 0, maxDelayMs: 0)
        #expect(network.nextDelayMs() == 0)
        try await network.delay()
    }

    @Test func sameSeedProducesSameDelaySequence() {
        let first = MockNetwork(minDelayMs: 300, maxDelayMs: 800, seed: 7)
        let second = MockNetwork(minDelayMs: 300, maxDelayMs: 800, seed: 7)
        let firstSequence = (0..<20).map { _ in first.nextDelayMs() }
        let secondSequence = (0..<20).map { _ in second.nextDelayMs() }
        #expect(firstSequence == secondSequence)
    }
}

import Testing
@testable import BillPayments

struct UiEventBusTests {

    @Test func deliversEmittedEventsInOrder() async {
        let bus = UiEventBus()
        var iterator = bus.events.makeAsyncIterator()
        bus.emit(.paymentStarted(paymentId: "pay-1"))
        bus.emit(.otpRejected)
        let first = await iterator.next()
        let second = await iterator.next()
        #expect(first == .paymentStarted(paymentId: "pay-1"))
        #expect(second == .otpRejected)
    }

    @Test func buffersEventsEmittedBeforeCollection() async {
        let bus = UiEventBus()
        bus.emit(.storageFailed)
        var iterator = bus.events.makeAsyncIterator()
        let event = await iterator.next()
        #expect(event == .storageFailed)
    }
}

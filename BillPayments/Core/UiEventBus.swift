final class UiEventBus {
    let events: AsyncStream<UiEvent>
    private let continuation: AsyncStream<UiEvent>.Continuation

    init() {
        (events, continuation) = AsyncStream.makeStream(bufferingPolicy: .unbounded)
    }

    func emit(_ event: UiEvent) {
        continuation.yield(event)
    }
}

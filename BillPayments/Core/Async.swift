enum Async<T> {
    case loading(previous: T?)
    case data(T)
    case error(any Error)

    var valueOrNull: T? {
        switch self {
        case .data(let value): value
        case .loading(let previous): previous
        case .error: nil
        }
    }
}

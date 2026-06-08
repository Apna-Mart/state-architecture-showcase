enum UiEvent: Equatable {
    case paymentStarted(paymentId: String)
    case paymentFailed(paymentId: String)
    case otpRejected
    case authFailed
    case storageFailed
}

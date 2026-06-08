enum Auth: Equatable {
    case unauthenticated
    case sendingOtp(phone: String)
    case otpSent(phone: String)
    case verifying(phone: String)
    case authenticated(userId: String, phone: String)
}

extension Auth {
    var userIdOrNull: String? {
        if case let .authenticated(userId, _) = self { return userId }
        return nil
    }
}

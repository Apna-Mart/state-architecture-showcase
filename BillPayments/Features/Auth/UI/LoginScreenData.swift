enum LoginScreenData: Equatable {
    case phoneEntry(phone: String, canSend: Bool, sending: Bool)
    case otpEntry(phone: String, otp: String, canVerify: Bool, verifying: Bool)
}

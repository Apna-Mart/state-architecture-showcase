import Observation

@Observable
final class LoginScreenModel {
    @ObservationIgnored private let authStore: AuthStore

    var phone = ""
    var otp = ""

    init(authStore: AuthStore, phone: String = "") {
        self.authStore = authStore
        self.phone = phone
    }

    var data: LoginScreenData {
        let validPhone = phone.count == 10 && Int64(phone) != nil
        switch authStore.state {
        case .unauthenticated:
            return .phoneEntry(phone: phone, canSend: validPhone, sending: false)
        case .sendingOtp:
            return .phoneEntry(phone: phone, canSend: false, sending: true)
        case let .otpSent(statePhone):
            return .otpEntry(phone: statePhone, otp: otp, canVerify: otp.count == 6, verifying: false)
        case let .verifying(statePhone):
            return .otpEntry(phone: statePhone, otp: otp, canVerify: false, verifying: true)
        case .authenticated:
            return .phoneEntry(phone: phone, canSend: false, sending: false)
        }
    }

    func sendOtp() {
        authStore.sendOtp(phone: phone)
    }

    func verifyOtp() {
        authStore.verifyOtp(code: otp)
    }

    func changeNumber() {
        otp = ""
        authStore.logout()
    }
}

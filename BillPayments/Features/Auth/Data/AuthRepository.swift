struct InvalidOtpError: Error {}

protocol AuthRepository {
    func sendOtp(phone: String) async throws
    func verifyOtp(phone: String, code: String) async throws -> String
}

final class FakeAuthRepository: AuthRepository {
    private let network: MockNetwork

    init(network: MockNetwork) {
        self.network = network
    }

    func sendOtp(phone: String) async throws {
        try await network.delay()
    }

    func verifyOtp(phone: String, code: String) async throws -> String {
        try await network.delay()
        let isSixDigits = code.count == 6 && Int(code) != nil
        guard isSixDigits else { throw InvalidOtpError() }
        return "user-\(phone)"
    }
}

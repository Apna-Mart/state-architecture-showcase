import Observation

@Observable
final class AuthStore {
    private(set) var state: Auth
    @ObservationIgnored private(set) var pendingWork: Task<Void, Never>?

    @ObservationIgnored private let authRepository: AuthRepository
    @ObservationIgnored private let sessionRepository: SessionRepository
    @ObservationIgnored private let events: UiEventBus

    init(
        authRepository: AuthRepository,
        sessionRepository: SessionRepository,
        events: UiEventBus
    ) {
        self.authRepository = authRepository
        self.sessionRepository = sessionRepository
        self.events = events
        self.state = Self.restore(sessionRepository)
    }

    private static func restore(_ sessionRepository: SessionRepository) -> Auth {
        guard let session = sessionRepository.restore() else { return .unauthenticated }
        return .authenticated(userId: session.userId, phone: session.phone)
    }

    func sendOtp(phone: String) {
        switch state {
        case .sendingOtp, .verifying: return
        default: break
        }
        state = .sendingOtp(phone: phone)
        pendingWork = Task {
            do {
                try await authRepository.sendOtp(phone: phone)
                state = .otpSent(phone: phone)
            } catch {
                state = .unauthenticated
                events.emit(.authFailed)
            }
        }
    }

    func verifyOtp(code: String) {
        guard case let .otpSent(phone) = state else { return }
        state = .verifying(phone: phone)
        pendingWork = Task {
            do {
                let userId = try await authRepository.verifyOtp(phone: phone, code: code)
                state = .authenticated(userId: userId, phone: phone)
                try await sessionRepository.save(userId: userId, phone: phone)
            } catch is InvalidOtpError {
                state = .otpSent(phone: phone)
                events.emit(.otpRejected)
            } catch {
                state = .otpSent(phone: phone)
                events.emit(.authFailed)
            }
        }
    }

    func logout() {
        pendingWork = Task { try? await sessionRepository.clear() }
        state = .unauthenticated
    }
}

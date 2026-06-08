import Observation

@Observable
final class PaymentsStore {
    private(set) var state: Payments
    @ObservationIgnored private(set) var pendingWork: Task<Void, Never>?
    @ObservationIgnored private(set) var observationWork: Task<Void, Never>?

    @ObservationIgnored private let paymentRepository: PaymentRepository
    @ObservationIgnored private let historyRepository: PaymentHistoryRepository
    @ObservationIgnored private let invalidateDueBills: () -> Void
    @ObservationIgnored private let events: UiEventBus
    @ObservationIgnored private let clock: Clock
    @ObservationIgnored private var epoch = 0
    @ObservationIgnored private(set) var userId: String?

    init(
        authStore: AuthStore,
        paymentRepository: PaymentRepository,
        historyRepository: PaymentHistoryRepository,
        invalidateDueBills: @escaping () -> Void,
        events: UiEventBus,
        clock: Clock
    ) {
        self.paymentRepository = paymentRepository
        self.historyRepository = historyRepository
        self.invalidateDueBills = invalidateDueBills
        self.events = events
        self.clock = clock
        if let id = authStore.state.userIdOrNull {
            self.userId = id
            self.state = historyRepository.restore(userId: id)
        } else {
            self.state = .empty
        }
        observationWork = Task { [weak self, authStore] in
            for await userId in Observations({ authStore.state.userIdOrNull }) {
                guard let self else { return }
                self.handleAuthChange(userId)
            }
        }
    }

    private func handleAuthChange(_ id: String?) {
        guard id != userId else { return }
        epoch += 1
        userId = id
        state = id.map { historyRepository.restore(userId: $0) } ?? .empty
    }

    func pay(billerId: String, billerName: String, categoryId: String, account: String, amountPaise: Int64) {
        if state.hasProcessing(billerId: billerId, account: account) { return }
        let payment = Payment(
            id: "pay-\(state.nextId)",
            billerId: billerId,
            billerName: billerName,
            categoryId: categoryId,
            account: account,
            amountPaise: amountPaise,
            paidAtUtc: clock.now(),
            status: .processing
        )
        state = state.adding(payment)
        events.emit(.paymentStarted(paymentId: payment.id))
        let startedEpoch = epoch
        pendingWork = Task {
            await persist()
            do {
                try await paymentRepository.pay(payment)
                if startedEpoch != epoch { return }
                state = state.updatingStatus(id: payment.id, status: .success)
                await persist()
                invalidateDueBills()
            } catch {
                if startedEpoch != epoch { return }
                state = state.updatingStatus(id: payment.id, status: .failed)
                await persist()
                events.emit(.paymentFailed(paymentId: payment.id))
            }
        }
    }

    private func persist() async {
        guard let id = userId else { return }
        do {
            try await historyRepository.persist(userId: id, value: state)
        } catch {
            events.emit(.storageFailed)
        }
    }
}

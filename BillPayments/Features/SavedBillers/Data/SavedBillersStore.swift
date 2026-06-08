import Observation

@Observable
final class SavedBillersStore {
    private(set) var state: SavedBillers
    @ObservationIgnored private(set) var pendingWork: Task<Void, Never>?
    @ObservationIgnored private(set) var observationWork: Task<Void, Never>?

    @ObservationIgnored private let repository: SavedBillersRepository
    @ObservationIgnored private let events: UiEventBus
    @ObservationIgnored private var epoch = 0
    @ObservationIgnored private(set) var userId: String?

    init(
        authStore: AuthStore,
        repository: SavedBillersRepository,
        events: UiEventBus
    ) {
        self.repository = repository
        self.events = events
        if let id = authStore.state.userIdOrNull {
            self.userId = id
            self.state = repository.restore(userId: id)
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
        state = id.map { repository.restore(userId: $0) } ?? .empty
    }

    func save(_ saved: SavedBiller) {
        if state.contains(billerId: saved.billerId, account: saved.account) { return }
        commit(state.adding(saved))
    }

    func remove(billerId: String, account: String) {
        commit(state.removing(billerId: billerId, account: account))
    }

    private func commit(_ next: SavedBillers) {
        guard let id = userId else { return }
        let previous = state
        let startedEpoch = epoch
        state = next
        pendingWork = Task {
            do {
                try await repository.persist(userId: id, value: next)
            } catch {
                if startedEpoch != epoch { return }
                state = previous
                events.emit(.storageFailed)
            }
        }
    }
}

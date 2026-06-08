import Foundation
import Observation

@Observable
final class DueBillsStore {
    private(set) var dueBills: Async<[FetchedBill]> = .loading(previous: nil)
    @ObservationIgnored private(set) var pendingWork: Task<Void, Never>?
    @ObservationIgnored private(set) var observationWork: Task<Void, Never>?

    @ObservationIgnored private let savedBillersStore: SavedBillersStore
    @ObservationIgnored private let repository: BillRepository
    @ObservationIgnored private let freshness: Freshness

    init(
        authStore: AuthStore,
        savedBillersStore: SavedBillersStore,
        repository: BillRepository,
        clock: Clock
    ) {
        self.savedBillersStore = savedBillersStore
        self.repository = repository
        self.freshness = Freshness(clock: clock, maxAge: 300)
        observationWork = Task { [weak self, authStore, savedBillersStore] in
            let inputs = Observations {
                _ = authStore.state.userIdOrNull
                return savedBillersStore.state.items
            }
            for await items in inputs {
                guard let self else { return }
                self.fetch(items)
            }
        }
    }

    func refreshIfStale() {
        if case .loading = dueBills { return }
        guard freshness.isStale() else { return }
        invalidate()
    }

    func invalidate() {
        fetch(savedBillersStore.state.items)
    }

    private func fetch(_ saved: [SavedBiller]) {
        pendingWork?.cancel()
        if saved.isEmpty {
            dueBills = .data([])
            return
        }
        dueBills = .loading(previous: dueBills.valueOrNull)
        pendingWork = Task {
            do {
                let bills = try await repository.fetchDueBills(saved: saved)
                if Task.isCancelled { return }
                dueBills = .data(bills)
                freshness.markFetched()
            } catch {
                if Task.isCancelled { return }
                dueBills = .error(error)
            }
        }
    }
}

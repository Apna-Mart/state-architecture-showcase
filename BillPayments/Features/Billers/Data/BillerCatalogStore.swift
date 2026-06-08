import Foundation
import Observation

@Observable
final class BillerCatalogStore {
    private(set) var catalog: Async<BillerCatalog> = .loading(previous: nil)
    @ObservationIgnored private(set) var pendingWork: Task<Void, Never>?
    @ObservationIgnored private(set) var observationWork: Task<Void, Never>?

    @ObservationIgnored private let repository: BillerRepository
    @ObservationIgnored private let settingsStore: SettingsStore
    @ObservationIgnored private let freshness: Freshness

    init(repository: BillerRepository, settingsStore: SettingsStore, clock: Clock) {
        self.repository = repository
        self.settingsStore = settingsStore
        self.freshness = Freshness(clock: clock, maxAge: 30 * 60)
        observationWork = Task { [weak self, settingsStore] in
            for await language in Observations({ settingsStore.language }) {
                guard let self else { return }
                self.fetch(language: language)
            }
        }
    }

    private func fetch(language: String) {
        pendingWork?.cancel()
        catalog = .loading(previous: catalog.valueOrNull)
        pendingWork = Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await self.repository.fetchCatalog(language: language)
                if Task.isCancelled { return }
                self.catalog = .data(result)
                self.freshness.markFetched()
            } catch {
                if Task.isCancelled { return }
                self.catalog = .error(error)
            }
        }
    }

    func refreshIfStale() {
        if case .loading = catalog { return }
        if !freshness.isStale() { return }
        fetch(language: settingsStore.language)
    }

    func retry() {
        fetch(language: settingsStore.language)
    }
}

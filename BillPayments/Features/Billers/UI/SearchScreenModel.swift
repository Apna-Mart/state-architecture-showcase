import Foundation
import Observation

@Observable
final class SearchScreenModel {
    @ObservationIgnored private let repository: BillerRepository
    @ObservationIgnored private let catalogStore: BillerCatalogStore
    @ObservationIgnored private let settingsStore: SettingsStore
    @ObservationIgnored private let debounce: Duration

    @ObservationIgnored private(set) var searchWork: Task<Void, Never>?

    var query = ""
    private(set) var results: Async<[Biller]> = .data([])

    init(
        repository: BillerRepository,
        catalogStore: BillerCatalogStore,
        settingsStore: SettingsStore,
        debounce: Duration = .milliseconds(200)
    ) {
        self.repository = repository
        self.catalogStore = catalogStore
        self.settingsStore = settingsStore
        self.debounce = debounce
    }

    var data: SearchScreenData {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.count < 2 { return .idle }
        switch results {
        case let .data(billers):
            if billers.isEmpty { return .empty(query: query) }
            let catalog = catalogStore.catalog.valueOrNull
            return .results(billers.map {
                BillerListItemData(
                    id: $0.id,
                    name: $0.name,
                    categoryName: catalog?.categoryById($0.categoryId)?.name ?? ""
                )
            })
        case .error:
            return .error(query: query)
        case .loading:
            return .searching
        }
    }

    func editQuery(_ value: String) {
        query = value
        runSearch()
    }

    func consumeLanguageChanges() async {
        for await _ in Observations({ [settingsStore] in settingsStore.language }) {
            runSearch()
        }
    }

    private func runSearch() {
        searchWork?.cancel()
        let value = query
        let language = settingsStore.language
        if value.trimmingCharacters(in: .whitespacesAndNewlines).count < 2 {
            results = .data([])
            return
        }
        results = .loading(previous: nil)
        searchWork = Task { [weak self] in
            guard let self else { return }
            try? await Task.sleep(for: self.debounce)
            if Task.isCancelled { return }
            do {
                let billers = try await self.repository.search(query: value, language: language)
                if Task.isCancelled { return }
                self.results = .data(billers)
            } catch {
                if Task.isCancelled { return }
                self.results = .error(error)
            }
        }
    }
}

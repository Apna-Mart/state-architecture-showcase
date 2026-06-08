import Foundation
import Testing
@testable import BillPayments

@MainActor
struct CategoryScreenModelTests {

    private func makeCatalog() async -> BillerCatalogStore {
        let settings = SettingsStore(
            repository: StoredSettingsRepository(store: InMemoryKeyValueStore()),
            systemLanguage: { "en" },
            readLanguageOverride: { nil },
            writeLanguageOverride: { _ in }
        )
        let catalog = BillerCatalogStore(
            repository: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0)),
            settingsStore: settings,
            clock: FixedClock(current: Date(timeIntervalSince1970: 0))
        )
        await waitUntil { catalog.catalog.valueOrNull != nil }
        return catalog
    }

    @Test func loadsFourBillersForCategory() async {
        let catalog = await makeCatalog()
        let model = CategoryScreenModel(categoryId: "electricity", catalogStore: catalog)
        guard case let .loaded(categoryName, billers) = model.data else {
            Issue.record("expected loaded, got \(model.data)")
            return
        }
        #expect(billers.count == 4)
        #expect(categoryName == "Electricity")
    }

    @Test func unknownCategoryYieldsError() async {
        let catalog = await makeCatalog()
        let model = CategoryScreenModel(categoryId: "nope", catalogStore: catalog)
        guard case .error = model.data else {
            Issue.record("expected error, got \(model.data)")
            return
        }
    }
}

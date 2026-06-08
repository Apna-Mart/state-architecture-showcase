import Foundation
import Testing
@testable import BillPayments

@MainActor
struct BillFetchScreenModelTests {

    private func makeCatalog() -> BillerCatalogStore {
        let settings = SettingsStore(
            repository: StoredSettingsRepository(store: InMemoryKeyValueStore()),
            systemLanguage: { "en" },
            readLanguageOverride: { nil },
            writeLanguageOverride: { _ in }
        )
        return BillerCatalogStore(
            repository: FakeBillerRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
            settingsStore: settings,
            clock: FixedClock(current: Date(timeIntervalSince1970: 0))
        )
    }

    private func makeModel(_ billerId: String) async -> BillFetchScreenModel {
        let catalog = makeCatalog()
        await waitUntil { catalog.catalog.valueOrNull != nil }
        return BillFetchScreenModel(catalogStore: catalog, billerId: billerId)
    }

    @Test func presentmentBillerShowsFetchActionGatedOnFields() async {
        let model = await makeModel("electricity-national")
        guard case let .form(_, _, submit) = model.data else { Issue.record("expected form"); return }
        #expect(submit.action == .fetchBill)
        #expect(submit.reviewRoute == nil)
        model.editField(key: "account", value: "12345")
        guard case let .form(_, _, ready) = model.data else { Issue.record("expected form"); return }
        #expect(ready.reviewRoute == .billReview(billerId: "electricity-national", account: "12345", amountPaise: nil))
    }

    @Test func openAmountBillerRequiresPositiveAmount() async {
        let model = await makeModel("dth-metro")
        model.editField(key: "account", value: "SUB99")
        guard case let .form(_, _, gated) = model.data else { Issue.record("expected form"); return }
        #expect(gated.reviewRoute == nil)
        model.editAmount("250.50")
        guard case let .form(_, _, ready) = model.data else { Issue.record("expected form"); return }
        #expect(ready.action == .continueToReview)
        #expect(ready.reviewRoute == .billReview(billerId: "dth-metro", account: "SUB99", amountPaise: 25050))
    }

    @Test func creditCardJoinsTwoFieldsWithPipe() async {
        let model = await makeModel("credit-card-city")
        model.editField(key: "card", value: "4321")
        model.editField(key: "mobile", value: "9876543210")
        guard
            case let .form(_, _, ready) = model.data,
            case let .billReview(_, account, _) = ready.reviewRoute
        else { Issue.record("expected review route"); return }
        #expect(account == "4321|9876543210")
    }

    @Test func unknownBillerYieldsError() async {
        let model = await makeModel("nope")
        guard case .error = model.data else { Issue.record("expected error"); return }
    }
}

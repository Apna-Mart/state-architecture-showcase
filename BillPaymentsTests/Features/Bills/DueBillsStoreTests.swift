import Foundation
import Testing
@testable import BillPayments

private final class CountingBillRepository: BillRepository {
    private let delegate: BillRepository
    private(set) var dueFetchCount = 0

    init(delegate: BillRepository) { self.delegate = delegate }

    func fetchBill(billerId: String, account: String) async throws -> FetchedBill {
        try await delegate.fetchBill(billerId: billerId, account: account)
    }

    func fetchDueBills(saved: [SavedBiller]) async throws -> [FetchedBill] {
        dueFetchCount += 1
        return try await delegate.fetchDueBills(saved: saved)
    }
}

@MainActor
private final class Fixture {
    let keyValueStore = InMemoryKeyValueStore()
    let bus = UiEventBus()
    let auth: AuthStore
    let saved: SavedBillersStore
    let repository: CountingBillRepository
    let store: DueBillsStore

    init(clock: Clock) {
        auth = AuthStore(
            authRepository: FakeAuthRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0)),
            sessionRepository: StoredSessionRepository(store: keyValueStore),
            events: bus
        )
        saved = SavedBillersStore(
            authStore: auth,
            repository: StoredSavedBillersRepository(store: keyValueStore),
            events: bus
        )
        repository = CountingBillRepository(
            delegate: FakeBillRepository(network: MockNetwork(minDelayMs: 0, maxDelayMs: 0), clock: clock)
        )
        store = DueBillsStore(authStore: auth, savedBillersStore: saved, repository: repository, clock: clock)
    }

    func login() async {
        auth.sendOtp(phone: "9876543210")
        await auth.pendingWork?.value
        auth.verifyOtp(code: "123456")
        await auth.pendingWork?.value
        await waitUntil { saved.userId != nil }
        await waitUntil { store.dueBills.valueOrNull != nil }
    }

    func awaitDueBills() async {
        await waitUntil { store.dueBills.valueOrNull?.isEmpty == false }
    }
}

@MainActor
struct DueBillsStoreTests {

    @Test func emptySavedBillersYieldsEmptyDueBillsWithoutFetch() async {
        let fixture = Fixture(clock: FixedClock())
        await fixture.login()
        #expect(fixture.store.dueBills.valueOrNull == [])
        #expect(fixture.repository.dueFetchCount == 0)
    }

    @Test func savedBillerTriggersDueBillFetch() async {
        let fixture = Fixture(clock: FixedClock())
        await fixture.login()
        fixture.saved.save(SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home"))
        await fixture.awaitDueBills()
        #expect(fixture.store.dueBills.valueOrNull?.count == 1)
    }

    @Test func refreshIfStaleHonorsFiveMinuteMaxAge() async {
        let clock = FixedClock()
        let fixture = Fixture(clock: clock)
        await fixture.login()
        fixture.saved.save(SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home"))
        await fixture.awaitDueBills()
        let countAfterLoad = fixture.repository.dueFetchCount
        fixture.store.refreshIfStale()
        await fixture.store.pendingWork?.value
        #expect(fixture.repository.dueFetchCount == countAfterLoad)
        clock.advance(by: 360)
        fixture.store.refreshIfStale()
        await fixture.store.pendingWork?.value
        #expect(fixture.repository.dueFetchCount == countAfterLoad + 1)
    }

    @Test func invalidateRefetches() async {
        let fixture = Fixture(clock: FixedClock())
        await fixture.login()
        fixture.saved.save(SavedBiller(billerId: "electricity-national", account: "12345", nickname: "Home"))
        await fixture.awaitDueBills()
        let countAfterLoad = fixture.repository.dueFetchCount
        fixture.store.invalidate()
        await fixture.store.pendingWork?.value
        #expect(fixture.repository.dueFetchCount == countAfterLoad + 1)
    }
}

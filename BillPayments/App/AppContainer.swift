import Foundation

final class AppContainer {
    let clock: Clock
    let network: MockNetwork
    let store: KeyValueStore
    let events: UiEventBus
    let router: Router
    let dateStream: DateStream
    let billerRepository: BillerRepository
    let billRepository: BillRepository

    let authStore: AuthStore
    let settingsStore: SettingsStore
    let savedBillersStore: SavedBillersStore
    let catalogStore: BillerCatalogStore
    let dueBillsStore: DueBillsStore
    let paymentsStore: PaymentsStore

    init() {
        let clock = SystemClock()
        let network = MockNetwork()
        let store = UserDefaultsKeyValueStore()
        let events = UiEventBus()

        let authRepository = FakeAuthRepository(network: network)
        let sessionRepository = StoredSessionRepository(store: store)
        let savedBillersRepository = StoredSavedBillersRepository(store: store)
        let settingsRepository = StoredSettingsRepository(store: store)
        let billerRepository = FakeBillerRepository(network: network)
        let billRepository = FakeBillRepository(network: network, clock: clock)
        let paymentRepository = FakePaymentRepository(network: network)
        let historyRepository = StoredPaymentHistoryRepository(store: store)

        let authStore = AuthStore(
            authRepository: authRepository,
            sessionRepository: sessionRepository,
            events: events
        )
        let settingsStore = SettingsStore(
            repository: settingsRepository,
            systemLanguage: {
                let preferred = (UserDefaults.standard.array(forKey: "AppleLanguages") as? [String])?
                    .first
                    .map { String($0.prefix(2)) }
                return preferred ?? Locale.current.language.languageCode?.identifier ?? "en"
            },
            readLanguageOverride: SettingsStore.readAppleLanguagesOverride,
            writeLanguageOverride: SettingsStore.writeAppleLanguagesOverride
        )
        let savedBillersStore = SavedBillersStore(
            authStore: authStore,
            repository: savedBillersRepository,
            events: events
        )
        let catalogStore = BillerCatalogStore(
            repository: billerRepository,
            settingsStore: settingsStore,
            clock: clock
        )
        let dueBillsStore = DueBillsStore(
            authStore: authStore,
            savedBillersStore: savedBillersStore,
            repository: billRepository,
            clock: clock
        )
        let paymentsStore = PaymentsStore(
            authStore: authStore,
            paymentRepository: paymentRepository,
            historyRepository: historyRepository,
            invalidateDueBills: dueBillsStore.invalidate,
            events: events,
            clock: clock
        )

        self.clock = clock
        self.network = network
        self.store = store
        self.events = events
        self.router = Router()
        self.dateStream = MidnightDateStream(clock: clock)
        self.billerRepository = billerRepository
        self.billRepository = billRepository
        self.authStore = authStore
        self.settingsStore = settingsStore
        self.savedBillersStore = savedBillersStore
        self.catalogStore = catalogStore
        self.dueBillsStore = dueBillsStore
        self.paymentsStore = paymentsStore
    }
}

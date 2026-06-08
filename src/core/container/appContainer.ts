import { systemClock, type Clock } from '../clock/clock';
import { InMemoryKeyValueStore, MmkvKeyValueStore, type KeyValueStore } from '../storage/keyValueStore';
import { MockNetwork } from '../mock/mockNetwork';
import { createUiEventQueue, type UiEventQueue } from '../event/uiEventQueue';
import { FakeAuthRepository, type AuthRepository } from '../../features/auth/data/authRepository';
import { StoredSessionRepository, type SessionRepository } from '../../features/auth/data/sessionRepository';
import { FakeBillerRepository, type BillerRepository } from '../../features/billers/data/billerRepository';
import { FakeBillRepository, type BillRepository } from '../../features/bills/data/billRepository';
import { FakePaymentRepository, type PaymentRepository } from '../../features/payments/data/paymentRepository';
import { StoredPaymentHistoryRepository, type PaymentHistoryRepository } from '../../features/payments/data/paymentHistoryRepository';
import { StoredSavedBillersRepository, type SavedBillersRepository } from '../../features/saved_billers/data/savedBillersRepository';
import { StoredSettingsRepository, type SettingsRepository } from '../../features/settings/data/settingsRepository';
import { createAuthStore, type AuthStore } from '../../features/auth/data/authStore';
import { createSettingsStore, type SettingsStore } from '../../features/settings/data/settingsStore';
import { createLocaleStore, type LocaleStore } from '../../l10n/localeStore';
import { createCatalogStore, type CatalogStore } from '../../features/billers/data/catalogStore';
import { createSearchStore, type SearchStore } from '../../features/billers/data/searchStore';
import { createPaymentsStore, type PaymentsStore } from '../../features/payments/data/paymentsStore';
import { createSavedBillersStore, type SavedBillersStore } from '../../features/saved_billers/data/savedBillersStore';
import { createDueBillsStore, type DueBillsStore } from '../../features/bills/data/dueBillsStore';
import { createBillsStore, type BillsStore } from '../../features/bills/data/billsStore';

export interface ContainerOverrides {
  keyValueStore?: KeyValueStore;
  network?: MockNetwork;
  clock?: Clock;
  authRepository?: AuthRepository;
  billerRepository?: BillerRepository;
  billRepository?: BillRepository;
  paymentRepository?: PaymentRepository;
}

export interface AppContainer {
  readonly clock: Clock;
  readonly keyValueStore: KeyValueStore;
  readonly uiEvents: UiEventQueue;
  readonly authRepository: AuthRepository;
  readonly sessionRepository: SessionRepository;
  readonly billerRepository: BillerRepository;
  readonly billRepository: BillRepository;
  readonly paymentRepository: PaymentRepository;
  readonly paymentHistoryRepository: PaymentHistoryRepository;
  readonly savedBillersRepository: SavedBillersRepository;
  readonly settingsRepository: SettingsRepository;
  readonly auth: AuthStore;
  readonly settings: SettingsStore;
  readonly locale: LocaleStore;
  readonly catalog: CatalogStore;
  readonly search: SearchStore;
  readonly bills: BillsStore;
  readonly payments: PaymentsStore;
  readonly savedBillers: SavedBillersStore;
  readonly dueBills: DueBillsStore;
}

export const createAppContainer = (overrides: ContainerOverrides = {}): AppContainer => {
  const clock = overrides.clock ?? systemClock;
  const keyValueStore = overrides.keyValueStore ?? new InMemoryKeyValueStore();
  const network = overrides.network ?? new MockNetwork();
  const uiEvents = createUiEventQueue();

  const authRepository = overrides.authRepository ?? new FakeAuthRepository(network);
  const sessionRepository = new StoredSessionRepository(keyValueStore);
  const billerRepository = overrides.billerRepository ?? new FakeBillerRepository(network);
  const billRepository = overrides.billRepository ?? new FakeBillRepository(network, clock);
  const paymentRepository = overrides.paymentRepository ?? new FakePaymentRepository(network);
  const paymentHistoryRepository = new StoredPaymentHistoryRepository(keyValueStore);
  const savedBillersRepository = new StoredSavedBillersRepository(keyValueStore);
  const settingsRepository = new StoredSettingsRepository(keyValueStore);

  const container = {} as { -readonly [K in keyof AppContainer]: AppContainer[K] };
  Object.assign(container, {
    clock, keyValueStore, uiEvents, authRepository, sessionRepository,
    billerRepository, billRepository, paymentRepository,
    paymentHistoryRepository, savedBillersRepository, settingsRepository,
  });

  const getContainer = (): AppContainer => container as AppContainer;

  container.auth = createAuthStore(getContainer);
  container.settings = createSettingsStore(getContainer);
  container.locale = createLocaleStore(getContainer);
  container.catalog = createCatalogStore(getContainer);
  container.search = createSearchStore(getContainer);
  container.savedBillers = createSavedBillersStore(getContainer);
  container.dueBills = createDueBillsStore(getContainer);
  container.bills = createBillsStore(getContainer);
  container.payments = createPaymentsStore(getContainer);

  return container as AppContainer;
};

export const productionContainer = (mmkv: MmkvKeyValueStore): AppContainer =>
  createAppContainer({ keyValueStore: mmkv, clock: systemClock });

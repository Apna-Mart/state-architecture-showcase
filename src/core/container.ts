import { QueryClient } from '@tanstack/react-query';
import { systemClock, type Clock } from './clock/clock';
import { MockNetwork } from './mock/mockNetwork';
import { InMemoryKeyValueStore, type KeyValueStore } from './storage/keyValueStore';
import { createUiEventStore, type UiEventStore } from './event/uiEvents';
import { FakeAuthRepository, type AuthRepository } from '@/features/auth/data/authRepository';
import { StoredSessionRepository, type SessionRepository } from '@/features/auth/data/sessionRepository';
import { FakeBillerRepository, type BillerRepository } from '@/features/billers/data/billerRepository';
import { FakeBillRepository, type BillRepository } from '@/features/bills/data/billRepository';
import { FakePaymentRepository, type PaymentRepository } from '@/features/payments/data/paymentRepository';
import { StoredPaymentHistoryRepository, type PaymentHistoryRepository } from '@/features/payments/data/paymentHistoryRepository';
import { StoredSavedBillersRepository, type SavedBillersRepository } from '@/features/saved_billers/data/savedBillersRepository';
import { StoredSettingsRepository, type SettingsRepository } from '@/features/settings/data/settingsRepository';
import { createAuthStore, type AuthStore } from '@/features/auth/data/authStore';
import { createPaymentsStore, type PaymentsStore } from '@/features/payments/data/paymentsStore';
import { createSavedBillersStore, type SavedBillersStore } from '@/features/saved_billers/data/savedBillersStore';
import { createSettingsStore, type SettingsStore } from '@/features/settings/data/settingsStore';

export type ContainerOverrides = {
  network?: MockNetwork;
  clock?: Clock;
  store?: KeyValueStore;
  authRepository?: AuthRepository;
};

export type AppContainer = {
  clock: Clock;
  queryClient: QueryClient;
  uiEvents: UiEventStore;
  auth: AuthStore;
  payments: PaymentsStore;
  savedBillers: SavedBillersStore;
  settings: SettingsStore;
  billerRepository: BillerRepository;
  billRepository: BillRepository;
  sessionRepository: SessionRepository;
};

export function createAppContainer(overrides: ContainerOverrides = {}): AppContainer {
  const network = overrides.network ?? new MockNetwork();
  const clock: Clock = overrides.clock ?? systemClock;
  const store: KeyValueStore = overrides.store ?? new InMemoryKeyValueStore();

  const authRepository = overrides.authRepository ?? new FakeAuthRepository(network);
  const sessionRepository = new StoredSessionRepository(store);
  const billerRepository = new FakeBillerRepository(network);
  const billRepository = new FakeBillRepository(network, clock);
  const paymentRepository: PaymentRepository = new FakePaymentRepository(network);
  const paymentHistoryRepository: PaymentHistoryRepository = new StoredPaymentHistoryRepository(store);
  const savedBillersRepository: SavedBillersRepository = new StoredSavedBillersRepository(store);
  const settingsRepository: SettingsRepository = new StoredSettingsRepository(store);

  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  });
  const uiEvents = createUiEventStore();

  const auth = createAuthStore({ authRepository, sessionRepository, uiEvents });
  const payments = createPaymentsStore({
    auth,
    uiEvents,
    clock,
    paymentRepository,
    paymentHistoryRepository,
    onPaySuccess: () => queryClient.invalidateQueries({ queryKey: ['dueBills'] }),
  });
  const savedBillers = createSavedBillersStore({ auth, uiEvents, savedBillersRepository });
  const settings = createSettingsStore({ settingsRepository });

  auth.subscribe((state, previous) => {
    if (userKey(state) === userKey(previous)) return;
    payments.getState().rebuildForUser();
    savedBillers.getState().rebuildForUser();
    if (userKey(state) === null) queryClient.clear();
  });

  return {
    clock,
    queryClient,
    uiEvents,
    auth,
    payments,
    savedBillers,
    settings,
    billerRepository,
    billRepository,
    sessionRepository,
  };
}

function userKey(state: { auth: import('@/features/auth/data/auth').Auth }): string | null {
  return state.auth.kind === 'authenticated' ? state.auth.userId : null;
}

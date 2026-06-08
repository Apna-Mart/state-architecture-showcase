import { createStore } from 'zustand/vanilla';
import { paymentFailed, paymentStarted, storageFailed, type UiEventStore } from '@/core/event/uiEvents';
import type { Clock } from '@/core/clock/clock';
import { userIdOrNull } from '@/features/auth/data/auth';
import type { AuthStore } from '@/features/auth/data/authStore';
import { addingPayment, emptyPayments, hasProcessing, updatingStatus, type Payment, type Payments } from './payment';
import type { PaymentRepository } from './paymentRepository';
import type { PaymentHistoryRepository } from './paymentHistoryRepository';

type Deps = {
  auth: AuthStore;
  uiEvents: UiEventStore;
  clock: Clock;
  paymentRepository: PaymentRepository;
  paymentHistoryRepository: PaymentHistoryRepository;
  onPaySuccess: () => void;
};

type PayInput = { billerId: string; billerName: string; categoryId: string; account: string; amountPaise: number };

export type PaymentsState = {
  payments: Payments;
  epoch: number;
  rebuildForUser(): void;
  pay(input: PayInput): Promise<void>;
};

export const createPaymentsStore = (deps: Deps) => {
  const restore = (): Payments => {
    const userId = userIdOrNull(deps.auth.getState().auth);
    return userId === null ? emptyPayments() : deps.paymentHistoryRepository.restore(userId);
  };

  const store = createStore<PaymentsState>((set, get) => ({
    payments: restore(),
    epoch: 0,
    rebuildForUser: () => set({ payments: restore(), epoch: get().epoch + 1 }),
    pay: async (input) => {
      const state = get();
      if (hasProcessing(state.payments, input.billerId, input.account)) return;
      const payment: Payment = {
        id: `pay-${state.payments.nextId}`,
        ...input,
        paidAtUtc: deps.clock().toISOString(),
        status: 'processing',
      };
      commit(addingPayment(state.payments, payment));
      deps.uiEvents.getState().emit(paymentStarted(payment.id));
      const epoch = get().epoch;
      try {
        await deps.paymentRepository.pay(payment);
        if (epoch !== get().epoch) return;
        commit(updatingStatus(get().payments, payment.id, 'success'));
        deps.onPaySuccess();
      } catch {
        if (epoch !== get().epoch) return;
        commit(updatingStatus(get().payments, payment.id, 'failed'));
        deps.uiEvents.getState().emit(paymentFailed(payment.id));
      }
    },
  }));

  const commit = (next: Payments) => {
    store.setState({ payments: next });
    const userId = userIdOrNull(deps.auth.getState().auth);
    if (userId === null) return;
    try {
      deps.paymentHistoryRepository.persist(userId, next);
    } catch {
      deps.uiEvents.getState().emit(storageFailed());
    }
  };

  return store;
};

export type PaymentsStore = ReturnType<typeof createPaymentsStore>;

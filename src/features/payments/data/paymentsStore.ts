import { createStore, type StoreApi } from 'zustand/vanilla';
import type { AppContainer } from '../../../core/container/appContainer';
import { userIdOrNull } from '../../auth/data/auth';
import { adding, emptyPayments, hasProcessing, updatingStatus, type Payment, type Payments } from './payment';

export interface PayInput {
  readonly billerId: string;
  readonly billerName: string;
  readonly categoryId: string;
  readonly account: string;
  readonly amountPaise: number;
}

export interface PaymentsState {
  readonly payments: Payments;
  pay(input: PayInput): Promise<void>;
}

export type PaymentsStore = StoreApi<PaymentsState>;

export const createPaymentsStore = (getContainer: () => AppContainer): PaymentsStore => {
  let epoch = 0;
  let userId = userIdOrNull(getContainer().auth.getState().auth);

  const restoreFor = (id: string | null): Payments =>
    id === null ? emptyPayments() : getContainer().paymentHistoryRepository.restore(id);

  const store = createStore<PaymentsState>((set, get) => {
    const persist = (next: Payments): void => {
      const id = userId;
      if (id === null) return;
      getContainer()
        .paymentHistoryRepository.persist(id, next)
        .catch(() => getContainer().uiEvents.getState().emit({ kind: 'storageFailed' }));
    };
    const setAndPersist = (next: Payments): void => {
      set({ payments: next });
      persist(next);
    };
    return {
      payments: restoreFor(userId),
      pay: async (input) => {
        if (hasProcessing(get().payments, input.billerId, input.account)) return;
        const payment: Payment = {
          id: `pay-${get().payments.nextId}`,
          billerId: input.billerId,
          billerName: input.billerName,
          categoryId: input.categoryId,
          account: input.account,
          amountPaise: input.amountPaise,
          paidAtUtc: new Date(getContainer().clock().getTime()),
          status: 'processing',
        };
        setAndPersist(adding(get().payments, payment));
        getContainer().uiEvents.getState().emit({ kind: 'paymentStarted', paymentId: payment.id });
        const myEpoch = epoch;
        try {
          await getContainer().paymentRepository.pay(payment);
          if (myEpoch !== epoch) return;
          setAndPersist(updatingStatus(get().payments, payment.id, 'success'));
          getContainer().dueBills.getState().invalidate();
        } catch {
          if (myEpoch !== epoch) return;
          setAndPersist(updatingStatus(get().payments, payment.id, 'failed'));
          getContainer().uiEvents.getState().emit({ kind: 'paymentFailed', paymentId: payment.id });
        }
      },
    };
  });

  getContainer().auth.subscribe((next) => {
    const nextUserId = userIdOrNull(next.auth);
    if (nextUserId === userId) return;
    epoch += 1;
    userId = nextUserId;
    store.setState({ payments: restoreFor(nextUserId) });
  });

  return store;
};

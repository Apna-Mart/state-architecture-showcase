import { createStore, type StoreApi } from 'zustand/vanilla';
import { asyncData, asyncError, asyncLoading, type Async } from '../../../core/async/async';
import type { AppContainer } from '../../../core/container/appContainer';
import type { FetchedBill } from './fetchedBill';

const keyOf = (billerId: string, account: string): string => `${billerId}|${account}`;

export interface BillsState {
  readonly bills: Readonly<Record<string, Async<FetchedBill>>>;
  ensureBill(billerId: string, account: string): void;
  invalidateBill(billerId: string, account: string): void;
  billFor(billerId: string, account: string): Async<FetchedBill> | undefined;
  whenSettled(): Promise<void>;
}

export type BillsStore = StoreApi<BillsState>;

export const createBillsStore = (getContainer: () => AppContainer): BillsStore => {
  let inFlight: Promise<unknown> = Promise.resolve();
  return createStore<BillsState>((set, get) => {
    const fetch = (billerId: string, account: string): void => {
      const key = keyOf(billerId, account);
      set({ bills: { ...get().bills, [key]: asyncLoading() } });
      const promise = getContainer()
        .billRepository.fetchBill(billerId, account)
        .then((bill) => set({ bills: { ...get().bills, [key]: asyncData(bill) } }))
        .catch((error) => set({ bills: { ...get().bills, [key]: asyncError(error) } }));
      inFlight = Promise.all([inFlight, promise]);
    };
    return {
      bills: {},
      billFor: (billerId, account) => get().bills[keyOf(billerId, account)],
      ensureBill: (billerId, account) => {
        if (get().bills[keyOf(billerId, account)] !== undefined) return;
        fetch(billerId, account);
      },
      invalidateBill: (billerId, account) => fetch(billerId, account),
      whenSettled: async () => { await inFlight; },
    };
  });
};

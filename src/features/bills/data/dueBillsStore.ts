import { createStore, type StoreApi } from 'zustand/vanilla';
import { asyncData, asyncError, asyncLoading, type Async } from '../../../core/async/async';
import { Freshness } from '../../../core/cache/freshness';
import type { AppContainer } from '../../../core/container/appContainer';
import { userIdOrNull } from '../../auth/data/auth';
import type { FetchedBill } from './fetchedBill';

const MAX_AGE_MS = 5 * 60_000;

export interface DueBillsState {
  readonly dueBills: Async<readonly FetchedBill[]>;
  ensureLoaded(): void;
  refreshIfStale(): void;
  invalidate(): void;
  whenSettled(): Promise<void>;
}

export type DueBillsStore = StoreApi<DueBillsState>;

export const createDueBillsStore = (getContainer: () => AppContainer): DueBillsStore => {
  const freshness = new Freshness(getContainer().clock, MAX_AGE_MS);
  let inFlight: Promise<void> | null = null;
  let epoch = 0;
  let loadedOnce = false;

  const store = createStore<DueBillsState>((set, get) => {
    const load = (): Promise<void> => {
      epoch += 1;
      const myEpoch = epoch;
      set({ dueBills: asyncLoading() });
      const saved = getContainer().savedBillers.getState().savedBillers.items;
      if (saved.length === 0) {
        freshness.markFetched();
        set({ dueBills: asyncData([]) });
        inFlight = Promise.resolve();
        return inFlight;
      }
      inFlight = getContainer()
        .billRepository.fetchDueBills(saved)
        .then((bills) => {
          if (myEpoch !== epoch) return;
          freshness.markFetched();
          set({ dueBills: asyncData(bills) });
        })
        .catch((error) => {
          if (myEpoch !== epoch) return;
          set({ dueBills: asyncError(error) });
        })
        .finally(() => { inFlight = null; });
      return inFlight;
    };
    return {
      dueBills: asyncLoading(),
      ensureLoaded: () => {
        if (loadedOnce) return;
        loadedOnce = true;
        void load();
      },
      refreshIfStale: () => {
        if (get().dueBills.status === 'loading' || inFlight !== null) return;
        if (!freshness.isStale()) return;
        void load();
      },
      invalidate: () => { if (loadedOnce) void load(); },
      whenSettled: async () => { await inFlight; },
    };
  });

  getContainer().savedBillers.subscribe(() => { if (loadedOnce) void store.getState().invalidate(); });
  getContainer().auth.subscribe((next, prev) => {
    if (userIdOrNull(next.auth) === userIdOrNull(prev.auth)) return;
    epoch += 1;
    loadedOnce = false;
    store.setState({ dueBills: asyncLoading() });
  });

  return store;
};

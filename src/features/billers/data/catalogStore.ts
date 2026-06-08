import { createStore, type StoreApi } from 'zustand/vanilla';
import { asyncData, asyncError, asyncLoading, type Async } from '../../../core/async/async';
import { Freshness } from '../../../core/cache/freshness';
import type { AppContainer } from '../../../core/container/appContainer';
import type { BillerCatalog } from './billerCatalog';

const MAX_AGE_MS = 30 * 60_000;

export interface CatalogState {
  readonly catalog: Async<BillerCatalog>;
  ensureLoaded(): void;
  refreshIfStale(): void;
  reload(): void;
  whenSettled(): Promise<void>;
}

export type CatalogStore = StoreApi<CatalogState>;

export const createCatalogStore = (getContainer: () => AppContainer): CatalogStore => {
  const freshness = new Freshness(getContainer().clock, MAX_AGE_MS);
  let inFlight: Promise<void> | null = null;
  let loadedOnce = false;

  const store = createStore<CatalogState>((set, get) => {
    const load = (): Promise<void> => {
      set({ catalog: asyncLoading() });
      const language = getContainer().locale.getState().language;
      inFlight = getContainer()
        .billerRepository.fetchCatalog(language)
        .then((catalog) => {
          freshness.markFetched();
          set({ catalog: asyncData(catalog) });
        })
        .catch((error) => set({ catalog: asyncError(error) }))
        .finally(() => { inFlight = null; });
      return inFlight;
    };
    return {
      catalog: asyncLoading(),
      ensureLoaded: () => {
        if (loadedOnce) return;
        loadedOnce = true;
        void load();
      },
      refreshIfStale: () => {
        if (get().catalog.status === 'loading' || inFlight !== null) return;
        if (!freshness.isStale()) return;
        void load();
      },
      reload: () => { void load(); },
      whenSettled: async () => { await inFlight; },
    };
  });

  getContainer().locale.subscribe((next, prev) => {
    if (next.language === prev.language || !loadedOnce) return;
    store.getState().reload();
  });

  return store;
};

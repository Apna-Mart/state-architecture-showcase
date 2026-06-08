import { createStore, type StoreApi } from 'zustand/vanilla';
import { asyncData, asyncError, asyncLoading, type Async } from '../../../core/async/async';
import type { AppContainer } from '../../../core/container/appContainer';
import type { Biller } from './biller';

const DEBOUNCE_MS = 200;

export interface SearchState {
  readonly query: string;
  readonly results: Readonly<Record<string, Async<readonly Biller[]>>>;
  setQuery(query: string): void;
  resultFor(query: string): Async<readonly Biller[]> | undefined;
}

export type SearchStore = StoreApi<SearchState>;

export const createSearchStore = (getContainer: () => AppContainer): SearchStore => {
  let epoch = 0;
  let timer: ReturnType<typeof setTimeout> | null = null;

  return createStore<SearchState>((set, get) => ({
    query: '',
    results: {},
    resultFor: (query) => get().results[query],
    setQuery: (query) => {
      set({ query });
      if (timer !== null) clearTimeout(timer);
      if (query.trim().length < 2) return;
      epoch += 1;
      const myEpoch = epoch;
      set({ results: { ...get().results, [query]: asyncLoading() } });
      timer = setTimeout(() => {
        const language = getContainer().locale.getState().language;
        getContainer()
          .billerRepository.search(query, language)
          .then((billers) => {
            if (myEpoch !== epoch) return;
            set({ results: { ...get().results, [query]: asyncData(billers) } });
          })
          .catch((error) => {
            if (myEpoch !== epoch) return;
            set({ results: { ...get().results, [query]: asyncError(error) } });
          });
      }, DEBOUNCE_MS);
    },
  }));
};

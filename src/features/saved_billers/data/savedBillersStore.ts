import { createStore, type StoreApi } from 'zustand/vanilla';
import type { AppContainer } from '../../../core/container/appContainer';
import { userIdOrNull } from '../../auth/data/auth';
import { addingSaved, contains, emptySavedBillers, removingSaved, type SavedBiller, type SavedBillers } from './savedBiller';

export interface SavedBillersState {
  readonly savedBillers: SavedBillers;
  save(item: SavedBiller): Promise<void>;
  remove(billerId: string, account: string): Promise<void>;
}

export type SavedBillersStore = StoreApi<SavedBillersState>;

export const createSavedBillersStore = (getContainer: () => AppContainer): SavedBillersStore => {
  let epoch = 0;
  let userId = userIdOrNull(getContainer().auth.getState().auth);

  const restoreFor = (id: string | null): SavedBillers =>
    id === null ? emptySavedBillers() : getContainer().savedBillersRepository.restore(id);

  const store = createStore<SavedBillersState>((set, get) => {
    const commit = async (next: SavedBillers): Promise<void> => {
      const id = userId;
      if (id === null) return;
      const previous = get().savedBillers;
      const myEpoch = epoch;
      set({ savedBillers: next });
      try {
        await getContainer().savedBillersRepository.persist(id, next);
      } catch {
        if (myEpoch !== epoch) return;
        set({ savedBillers: previous });
        getContainer().uiEvents.getState().emit({ kind: 'storageFailed' });
      }
    };
    return {
      savedBillers: restoreFor(userId),
      save: (item) => {
        if (contains(get().savedBillers, item.billerId, item.account)) return Promise.resolve();
        return commit(addingSaved(get().savedBillers, item));
      },
      remove: (billerId, account) => commit(removingSaved(get().savedBillers, billerId, account)),
    };
  });

  getContainer().auth.subscribe((next) => {
    const nextUserId = userIdOrNull(next.auth);
    if (nextUserId === userId) return;
    epoch += 1;
    userId = nextUserId;
    store.setState({ savedBillers: restoreFor(nextUserId) });
  });

  return store;
};

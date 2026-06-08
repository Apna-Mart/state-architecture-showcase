import { createStore } from 'zustand/vanilla';
import { storageFailed, type UiEventStore } from '@/core/event/uiEvents';
import { userIdOrNull } from '@/features/auth/data/auth';
import type { AuthStore } from '@/features/auth/data/authStore';
import { addingSaved, emptySavedBillers, removingSaved, savedContains, type SavedBiller, type SavedBillers } from './savedBiller';
import type { SavedBillersRepository } from './savedBillersRepository';

type Deps = { auth: AuthStore; uiEvents: UiEventStore; savedBillersRepository: SavedBillersRepository };

export type SavedBillersState = {
  savedBillers: SavedBillers;
  epoch: number;
  rebuildForUser(): void;
  save(entry: SavedBiller): Promise<void>;
  remove(billerId: string, account: string): Promise<void>;
};

export const createSavedBillersStore = (deps: Deps) => {
  const restore = (): SavedBillers => {
    const userId = userIdOrNull(deps.auth.getState().auth);
    return userId === null ? emptySavedBillers() : deps.savedBillersRepository.restore(userId);
  };

  return createStore<SavedBillersState>((set, get) => {
    const commit = async (next: SavedBillers): Promise<void> => {
      const userId = userIdOrNull(deps.auth.getState().auth);
      if (userId === null) return;
      const previous = get().savedBillers;
      const epoch = get().epoch;
      set({ savedBillers: next });
      try {
        deps.savedBillersRepository.persist(userId, next);
      } catch {
        if (epoch !== get().epoch) return;
        set({ savedBillers: previous });
        deps.uiEvents.getState().emit(storageFailed());
      }
    };

    return {
      savedBillers: restore(),
      epoch: 0,
      rebuildForUser: () => set({ savedBillers: restore(), epoch: get().epoch + 1 }),
      save: async (entry) => {
        if (savedContains(get().savedBillers, entry.billerId, entry.account)) return;
        await commit(addingSaved(get().savedBillers, entry));
      },
      remove: async (billerId, account) => {
        await commit(removingSaved(get().savedBillers, billerId, account));
      },
    };
  });
};

export type SavedBillersStore = ReturnType<typeof createSavedBillersStore>;

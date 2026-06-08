import { createStore, type StoreApi } from 'zustand/vanilla';
import type { UiEvent } from './uiEvent';

export interface UiEventQueueState {
  readonly events: readonly UiEvent[];
  emit(event: UiEvent): void;
  consume(event: UiEvent): void;
}

export type UiEventQueue = StoreApi<UiEventQueueState>;

export const createUiEventQueue = (): UiEventQueue =>
  createStore<UiEventQueueState>((set, get) => ({
    events: [],
    emit: (event) => set({ events: [...get().events, event] }),
    consume: (event) => {
      const index = get().events.indexOf(event);
      if (index < 0) return;
      const next = [...get().events];
      next.splice(index, 1);
      set({ events: next });
    },
  }));

import { createStore } from 'zustand/vanilla';

export type UiEvent =
  | { kind: 'paymentStarted'; paymentId: string; token: number }
  | { kind: 'paymentFailed'; paymentId: string; token: number }
  | { kind: 'otpRejected'; token: number }
  | { kind: 'authFailed'; token: number }
  | { kind: 'storageFailed'; token: number };

let nextToken = 0;
const mint = () => (nextToken += 1);

export const paymentStarted = (paymentId: string): UiEvent => ({ kind: 'paymentStarted', paymentId, token: mint() });
export const paymentFailed = (paymentId: string): UiEvent => ({ kind: 'paymentFailed', paymentId, token: mint() });
export const otpRejected = (): UiEvent => ({ kind: 'otpRejected', token: mint() });
export const authFailed = (): UiEvent => ({ kind: 'authFailed', token: mint() });
export const storageFailed = (): UiEvent => ({ kind: 'storageFailed', token: mint() });

export type UiEventState = {
  events: UiEvent[];
  emit(event: UiEvent): void;
  consume(event: UiEvent): void;
};

export const createUiEventStore = () =>
  createStore<UiEventState>((set) => ({
    events: [],
    emit: (event) => set((state) => ({ events: [...state.events, event] })),
    consume: (event) =>
      set((state) => ({ events: state.events.filter((e) => e.token !== event.token) })),
  }));

export type UiEventStore = ReturnType<typeof createUiEventStore>;

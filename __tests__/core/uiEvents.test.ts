import { createUiEventStore, paymentFailed, otpRejected } from '@/core/event/uiEvents';

describe('uiEvent queue', () => {
  test('emit appends and consume removes exactly one occurrence', () => {
    const store = createUiEventStore();
    store.getState().emit(paymentFailed('p1'));
    store.getState().emit(paymentFailed('p1'));
    expect(store.getState().events.length).toBe(2);
    store.getState().consume(store.getState().events[0]!);
    expect(store.getState().events.length).toBe(1);
    store.getState().consume(store.getState().events[0]!);
    expect(store.getState().events.length).toBe(0);
  });

  test('consume of absent event is a no-op', () => {
    const store = createUiEventStore();
    const ghost = otpRejected();
    store.getState().consume(ghost);
    expect(store.getState().events.length).toBe(0);
  });
});

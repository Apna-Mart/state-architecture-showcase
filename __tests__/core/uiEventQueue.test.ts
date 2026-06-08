import { createUiEventQueue } from '@/core/event/uiEventQueue';

describe('UiEventQueue', () => {
  it('emit appends and consume removes exactly one occurrence', () => {
    const queue = createUiEventQueue();
    queue.getState().emit({ kind: 'paymentFailed', paymentId: 'p1' });
    queue.getState().emit({ kind: 'paymentFailed', paymentId: 'p1' });
    expect(queue.getState().events.length).toBe(2);
    queue.getState().consume(queue.getState().events[0]!);
    expect(queue.getState().events.length).toBe(1);
    queue.getState().consume(queue.getState().events[0]!);
    expect(queue.getState().events.length).toBe(0);
  });

  it('consume of an absent event is a no-op', () => {
    const queue = createUiEventQueue();
    queue.getState().consume({ kind: 'otpRejected' });
    expect(queue.getState().events.length).toBe(0);
  });
});

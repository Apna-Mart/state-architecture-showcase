import { createAppContainer } from '@/core/container/appContainer';
import { InMemoryKeyValueStore, ThrowingWritesKeyValueStore } from '@/core/storage/keyValueStore';
import { MockNetwork } from '@/core/mock/mockNetwork';

const withFailEvery = (failEvery: number, over = {}) =>
  createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1, failEvery }), ...over });

const login = async (c: ReturnType<typeof withFailEvery>, phone = '9876543210') => {
  await c.auth.getState().sendOtp(phone);
  await c.auth.getState().verifyOtp('123456');
};

const payOnce = (c: ReturnType<typeof withFailEvery>) =>
  c.payments.getState().pay({
    billerId: 'electricity-metro', billerName: 'Metro Electricity',
    categoryId: 'electricity', account: 'K123', amountPaise: 45000,
  });

describe('PaymentsStore', () => {
  it('pay appends processing, marks success, emits paymentStarted', async () => {
    const c = withFailEvery(100);
    await login(c);
    await payOnce(c);
    expect(c.payments.getState().payments.items.length).toBe(1);
    expect(c.payments.getState().payments.items[0]!.status).toBe('success');
    expect(c.uiEvents.getState().events.filter((e) => e.kind === 'paymentStarted').length).toBe(1);
  });

  it('pay marks failed and emits paymentFailed on decline', async () => {
    const c = withFailEvery(1);
    await login(c);
    await payOnce(c);
    expect(c.payments.getState().payments.items[0]!.status).toBe('failed');
    expect(c.uiEvents.getState().events.some((e) => e.kind === 'paymentFailed')).toBe(true);
  });

  it('re-entry for the same bill while processing is ignored', async () => {
    const c = withFailEvery(100);
    await login(c);
    await Promise.all([payOnce(c), payOnce(c)]);
    expect(c.payments.getState().payments.items.length).toBe(1);
  });

  it('logout while a pay is in flight discards the stale completion', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 5, maxDelayMs: 6, failEvery: 100 }) });
    await login(c);
    const pending = payOnce(c);
    c.auth.getState().logout();
    await pending;
    expect(c.payments.getState().payments.items.length).toBe(0);
    expect(c.uiEvents.getState().events.some((e) => e.kind === 'paymentFailed')).toBe(false);
  });

  it('persist failure keeps the record and emits storageFailed', async () => {
    const c = withFailEvery(100, { keyValueStore: new ThrowingWritesKeyValueStore('payments.') });
    await login(c);
    await payOnce(c);
    expect(c.payments.getState().payments.items[0]!.status).toBe('success');
    expect(c.uiEvents.getState().events.some((e) => e.kind === 'storageFailed')).toBe(true);
  });

  it('successful pay invalidates due bills', async () => {
    const c = withFailEvery(100);
    await login(c);
    await c.savedBillers.getState().save({ billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
    c.dueBills.getState().ensureLoaded();
    await c.dueBills.getState().whenSettled();
    let notifications = 0;
    const unsub = c.dueBills.subscribe(() => { notifications += 1; });
    await payOnce(c);
    await c.dueBills.getState().whenSettled();
    expect(notifications).toBeGreaterThan(0);
    unsub();
  });

  it('logout wipes payment history; same user relogin restores it', async () => {
    const store = new InMemoryKeyValueStore();
    const c = withFailEvery(100, { keyValueStore: store });
    await login(c);
    await payOnce(c);
    c.auth.getState().logout();
    expect(c.payments.getState().payments.items.length).toBe(0);
    await login(c);
    expect(c.payments.getState().payments.items[0]!.status).toBe('success');
  });

  it('interrupted processing payment restores as failed', () => {
    const store = new InMemoryKeyValueStore();
    void store.write('payments.user-9876543210',
      '{"nextId":2,"items":[{"id":"pay-1","billerId":"electricity-metro","billerName":"Metro Electricity","categoryId":"electricity","account":"K123","amountPaise":45000,"paidAtUtc":"2026-06-05T10:00:00.000Z","status":"processing"}]}');
    void store.write('session.userId', 'user-9876543210');
    void store.write('session.phone', '9876543210');
    const c = withFailEvery(100, { keyValueStore: store });
    expect(c.payments.getState().payments.items[0]!.status).toBe('failed');
    expect(c.payments.getState().payments.nextId).toBe(2);
  });
});

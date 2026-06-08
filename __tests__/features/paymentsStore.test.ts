import { createAppContainer } from '@/core/container';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { ThrowingWriteStore } from '@/core/storage/keyValueStore';

const pay = (c: ReturnType<typeof createAppContainer>) =>
  c.payments.getState().pay({
    billerId: 'electricity-metro', billerName: 'Metro Electricity',
    categoryId: 'electricity', account: 'K123', amountPaise: 45000,
  });

const login = async (c: ReturnType<typeof createAppContainer>, phone = '9876543210') => {
  await c.auth.getState().sendOtp(phone);
  await c.auth.getState().verifyOtp('123456');
};

const failingEvery = (n: number) =>
  createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1, failEvery: n }) });

test('pay appends processing then marks success and emits paymentStarted', async () => {
  const c = failingEvery(100);
  await login(c);
  await pay(c);
  expect(c.payments.getState().payments.items).toHaveLength(1);
  expect(c.payments.getState().payments.items[0]!.status).toBe('success');
  expect(c.uiEvents.getState().events.filter((e) => e.kind === 'paymentStarted')).toHaveLength(1);
});

test('pay marks failed and emits paymentFailed on decline', async () => {
  const c = failingEvery(1);
  await login(c);
  await pay(c);
  expect(c.payments.getState().payments.items[0]!.status).toBe('failed');
  expect(c.uiEvents.getState().events.filter((e) => e.kind === 'paymentFailed')).toHaveLength(1);
});

test('pay re-entry for same bill while processing is ignored', async () => {
  const c = failingEvery(100);
  await login(c);
  await Promise.all([pay(c), pay(c)]);
  expect(c.payments.getState().payments.items).toHaveLength(1);
});

test('logout while pay is in flight discards the stale completion', async () => {
  const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 5, maxDelayMs: 6, failEvery: 100 }) });
  await login(c);
  const inflight = pay(c);
  c.auth.getState().logout();
  await inflight;
  expect(c.payments.getState().payments.items).toHaveLength(0);
  expect(c.uiEvents.getState().events.filter((e) => e.kind === 'paymentFailed')).toHaveLength(0);
});

test('persist failure keeps the payment record and emits storageFailed', async () => {
  const c = createAppContainer({
    network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1, failEvery: 100 }),
    store: new ThrowingWriteStore('payments.'),
  });
  await login(c);
  await pay(c);
  expect(c.payments.getState().payments.items[0]!.status).toBe('success');
  expect(c.uiEvents.getState().events.some((e) => e.kind === 'storageFailed')).toBe(true);
});

test('logout wipes payment history', async () => {
  const c = failingEvery(100);
  await login(c);
  await pay(c);
  c.auth.getState().logout();
  expect(c.payments.getState().payments.items).toHaveLength(0);
});

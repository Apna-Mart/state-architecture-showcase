import { createAppContainer } from '@/core/container';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';

const containerWith = (store: InMemoryKeyValueStore) =>
  createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1, failEvery: 100 }), store });
const login = async (c: ReturnType<typeof createAppContainer>, phone: string) => {
  await c.auth.getState().sendOtp(phone);
  await c.auth.getState().verifyOtp('123456');
};
const payOnce = (c: ReturnType<typeof createAppContainer>) =>
  c.payments.getState().pay({ billerId: 'electricity-metro', billerName: 'Metro Electricity', categoryId: 'electricity', account: 'K123', amountPaise: 45000 });

test('session restores authenticated state in a fresh container', async () => {
  const store = new InMemoryKeyValueStore();
  await login(containerWith(store), '9876543210');
  const second = containerWith(store);
  expect(second.auth.getState().auth).toEqual({ kind: 'authenticated', userId: 'user-9876543210', phone: '9876543210' });
});

test('saved billers and history restore after logout and relogin', async () => {
  const store = new InMemoryKeyValueStore();
  const c = containerWith(store);
  await login(c, '9876543210');
  await c.savedBillers.getState().save({ billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
  await payOnce(c);
  c.auth.getState().logout();
  expect(c.savedBillers.getState().savedBillers.items).toHaveLength(0);
  expect(c.payments.getState().payments.items).toHaveLength(0);
  await login(c, '9876543210');
  expect(c.savedBillers.getState().savedBillers.items[0]!.nickname).toBe('Home');
  expect(c.payments.getState().payments.items[0]!.status).toBe('success');
});

test('users see only their own bucket', async () => {
  const store = new InMemoryKeyValueStore();
  const c = containerWith(store);
  await login(c, '9876543210');
  await c.savedBillers.getState().save({ billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
  c.auth.getState().logout();
  await login(c, '1111111111');
  expect(c.savedBillers.getState().savedBillers.items).toHaveLength(0);
});

test('interrupted processing payment restores as failed', async () => {
  const store = new InMemoryKeyValueStore();
  store.write('payments.user-9876543210', '{"nextId":2,"items":[{"id":"pay-1","billerId":"electricity-metro","billerName":"Metro Electricity","categoryId":"electricity","account":"K123","amountPaise":45000,"paidAtUtc":"2026-06-05T10:00:00.000Z","status":"processing"}]}');
  store.write('session.userId', 'user-9876543210');
  store.write('session.phone', '9876543210');
  const c = containerWith(store);
  expect(c.payments.getState().payments.items[0]!.status).toBe('failed');
  expect(c.payments.getState().payments.nextId).toBe(2);
});

test('logout keeps the on-disk session cleared across containers', async () => {
  const store = new InMemoryKeyValueStore();
  const first = containerWith(store);
  await login(first, '9876543210');
  first.auth.getState().logout();
  const second = containerWith(store);
  expect(second.auth.getState().auth).toEqual({ kind: 'unauthenticated' });
});

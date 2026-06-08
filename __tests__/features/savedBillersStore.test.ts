import { createAppContainer } from '@/core/container';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { ThrowingWriteStore } from '@/core/storage/keyValueStore';

const bescom = { billerId: 'electricity-metro', account: 'K123', nickname: 'Home Power' };
const instant = (store?: ThrowingWriteStore) =>
  createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }), store });
const login = async (c: ReturnType<typeof createAppContainer>, phone = '9876543210') => {
  await c.auth.getState().sendOtp(phone);
  await c.auth.getState().verifyOtp('123456');
};

test('save adds once and ignores duplicates', async () => {
  const c = instant();
  await login(c);
  await c.savedBillers.getState().save(bescom);
  await c.savedBillers.getState().save(bescom);
  expect(c.savedBillers.getState().savedBillers.items).toHaveLength(1);
});

test('remove deletes by billerId and account', async () => {
  const c = instant();
  await login(c);
  await c.savedBillers.getState().save(bescom);
  await c.savedBillers.getState().remove('electricity-metro', 'K123');
  expect(c.savedBillers.getState().savedBillers.items).toHaveLength(0);
});

test('persist failure rolls back the optimistic save and emits storageFailed', async () => {
  const c = instant(new ThrowingWriteStore('savedBillers.'));
  await login(c);
  await c.savedBillers.getState().save(bescom);
  expect(c.savedBillers.getState().savedBillers.items).toHaveLength(0);
  expect(c.uiEvents.getState().events.map((e) => e.kind)).toEqual(['storageFailed']);
});

test('logout wipes saved billers and relogin starts clean', async () => {
  const c = instant();
  await login(c);
  await c.savedBillers.getState().save(bescom);
  c.auth.getState().logout();
  expect(c.savedBillers.getState().savedBillers.items).toHaveLength(0);
  await login(c, '1111111111');
  expect(c.savedBillers.getState().savedBillers.items).toHaveLength(0);
});

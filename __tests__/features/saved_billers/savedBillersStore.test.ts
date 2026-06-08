import { createAppContainer } from '@/core/container/appContainer';
import { InMemoryKeyValueStore, ThrowingWritesKeyValueStore } from '@/core/storage/keyValueStore';
import { MockNetwork } from '@/core/mock/mockNetwork';

const fast = (over = {}) =>
  createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }), ...over });

const login = async (c: ReturnType<typeof fast>, phone: string) => {
  await c.auth.getState().sendOtp(phone);
  await c.auth.getState().verifyOtp('123456');
};

const s = { billerId: 'electricity-metro', account: 'K123', nickname: 'Home Power' };

describe('SavedBillersStore', () => {
  it('save adds once and ignores duplicates', async () => {
    const c = fast();
    await login(c, '9876543210');
    await c.savedBillers.getState().save(s);
    await c.savedBillers.getState().save(s);
    expect(c.savedBillers.getState().savedBillers.items.length).toBe(1);
  });

  it('remove deletes by billerId + account', async () => {
    const c = fast();
    await login(c, '9876543210');
    await c.savedBillers.getState().save(s);
    await c.savedBillers.getState().remove('electricity-metro', 'K123');
    expect(c.savedBillers.getState().savedBillers.items.length).toBe(0);
  });

  it('persist failure rolls back the optimistic save and emits storageFailed', async () => {
    const c = fast({ keyValueStore: new ThrowingWritesKeyValueStore('savedBillers.') });
    await login(c, '9876543210');
    await c.savedBillers.getState().save(s);
    expect(c.savedBillers.getState().savedBillers.items.length).toBe(0);
    expect(c.uiEvents.getState().events).toEqual([{ kind: 'storageFailed' }]);
  });

  it('logout wipes saved billers and a different user starts clean', async () => {
    const store = new InMemoryKeyValueStore();
    const c = fast({ keyValueStore: store });
    await login(c, '9876543210');
    await c.savedBillers.getState().save(s);
    c.auth.getState().logout();
    expect(c.savedBillers.getState().savedBillers.items.length).toBe(0);
    await login(c, '1111111111');
    expect(c.savedBillers.getState().savedBillers.items.length).toBe(0);
  });

  it('relogin as the same user restores saved billers', async () => {
    const store = new InMemoryKeyValueStore();
    const c = fast({ keyValueStore: store });
    await login(c, '9876543210');
    await c.savedBillers.getState().save(s);
    c.auth.getState().logout();
    await login(c, '9876543210');
    expect(c.savedBillers.getState().savedBillers.items[0]!.nickname).toBe('Home Power');
  });
});

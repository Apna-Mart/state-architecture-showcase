import { createAppContainer } from '@/core/container/appContainer';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';
import { MockNetwork } from '@/core/mock/mockNetwork';

const fast = (store: InMemoryKeyValueStore) =>
  createAppContainer({ keyValueStore: store, network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });

const login = async (c: ReturnType<typeof fast>, phone: string) => {
  await c.auth.getState().sendOtp(phone);
  await c.auth.getState().verifyOtp('123456');
};
const payOnce = (c: ReturnType<typeof fast>) =>
  c.payments.getState().pay({ billerId: 'electricity-metro', billerName: 'Metro Electricity', categoryId: 'electricity', account: 'K123', amountPaise: 45000 });

describe('persistence across fresh containers', () => {
  it('session restores authenticated state', async () => {
    const store = new InMemoryKeyValueStore();
    await login(fast(store), '9876543210');
    const fresh = fast(store);
    expect(fresh.auth.getState().auth).toEqual({ kind: 'authenticated', userId: 'user-9876543210', phone: '9876543210' });
  });

  it('saved billers + history survive logout/relogin via on-disk buckets', async () => {
    const store = new InMemoryKeyValueStore();
    const c = fast(store);
    await login(c, '9876543210');
    await c.savedBillers.getState().save({ billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
    await payOnce(c);
    c.auth.getState().logout();
    expect(c.savedBillers.getState().savedBillers.items.length).toBe(0);
    await login(c, '9876543210');
    expect(c.savedBillers.getState().savedBillers.items[0]!.nickname).toBe('Home');
    expect(c.payments.getState().payments.items[0]!.status).toBe('success');
  });

  it('a different user sees only their own bucket', async () => {
    const store = new InMemoryKeyValueStore();
    const c = fast(store);
    await login(c, '9876543210');
    await c.savedBillers.getState().save({ billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
    c.auth.getState().logout();
    await login(c, '1111111111');
    expect(c.savedBillers.getState().savedBillers.items.length).toBe(0);
  });

  it('logout clears the on-disk session', async () => {
    const store = new InMemoryKeyValueStore();
    const c = fast(store);
    await login(c, '9876543210');
    c.auth.getState().logout();
    expect(fast(store).auth.getState().auth).toEqual({ kind: 'unauthenticated' });
  });
});

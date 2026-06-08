import { createAppContainer } from '@/core/container/appContainer';
import { MockNetwork } from '@/core/mock/mockNetwork';

const fast = () => createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
const login = async (c: ReturnType<typeof fast>) => {
  await c.auth.getState().sendOtp('9876543210');
  await c.auth.getState().verifyOtp('123456');
};

describe('DueBillsStore', () => {
  it('is empty when there are no saved billers', async () => {
    const c = fast();
    await login(c);
    c.dueBills.getState().ensureLoaded();
    await c.dueBills.getState().whenSettled();
    const state = c.dueBills.getState().dueBills;
    expect(state.status === 'data' && state.value.length).toBe(0);
  });

  it('refetches one bill after a biller is saved', async () => {
    const c = fast();
    await login(c);
    c.dueBills.getState().ensureLoaded();
    await c.dueBills.getState().whenSettled();
    await c.savedBillers.getState().save({ billerId: 'water-city', account: 'W9', nickname: 'Home Water' });
    await c.dueBills.getState().whenSettled();
    const state = c.dueBills.getState().dueBills;
    expect(state.status === 'data' && state.value[0]?.billerId).toBe('water-city');
  });
});

import { createAppContainer } from '@/core/container/appContainer';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { projectHomeCategories } from '@/features/home/ui/homeScreenData';

describe('rebuild isolation', () => {
  it('search typing never notifies catalog or payments subscribers', async () => {
    jest.useFakeTimers();
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    c.catalog.getState().ensureLoaded();
    await jest.runOnlyPendingTimersAsync();
    let catalogNotifs = 0;
    let paymentsNotifs = 0;
    const u1 = c.catalog.subscribe(() => { catalogNotifs += 1; });
    const u2 = c.payments.subscribe(() => { paymentsNotifs += 1; });
    c.search.getState().setQuery('metro');
    c.search.getState().setQuery('metro elec');
    await jest.advanceTimersByTimeAsync(200);
    await jest.runOnlyPendingTimersAsync();
    expect(catalogNotifs).toBe(0);
    expect(paymentsNotifs).toBe(0);
    u1(); u2();
    jest.useRealTimers();
  });

  it('saving a biller does not change the projected categories slice', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    await c.auth.getState().sendOtp('9876543210');
    await c.auth.getState().verifyOtp('123456');
    c.catalog.getState().ensureLoaded();
    await c.catalog.getState().whenSettled();
    const before = projectHomeCategories(c.catalog.getState().catalog);
    await c.savedBillers.getState().save({ billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
    const after = projectHomeCategories(c.catalog.getState().catalog);
    expect(after).toEqual(before);
  });
});

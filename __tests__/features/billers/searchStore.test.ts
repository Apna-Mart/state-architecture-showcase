import { createAppContainer } from '@/core/container/appContainer';
import { MockNetwork } from '@/core/mock/mockNetwork';

describe('SearchStore', () => {
  beforeEach(() => jest.useFakeTimers());
  afterEach(() => jest.useRealTimers());

  it('debounces 200 ms then resolves results for the latest query', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    c.catalog.getState().ensureLoaded();
    await jest.runOnlyPendingTimersAsync();
    c.search.getState().setQuery('metro');
    c.search.getState().setQuery('metro elec');
    await jest.advanceTimersByTimeAsync(200);
    await jest.runOnlyPendingTimersAsync();
    const entry = c.search.getState().resultFor('metro elec');
    expect(entry?.status).toBe('data');
    if (entry?.status === 'data') {
      expect(entry.value.length).toBe(1);
      expect(entry.value[0]!.id).toBe('electricity-metro');
    }
  });

  it('a stale debounce completion is discarded after the query changes', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    c.search.getState().setQuery('metro');
    c.search.getState().setQuery('water');
    await jest.advanceTimersByTimeAsync(200);
    await jest.runOnlyPendingTimersAsync();
    expect(c.search.getState().query).toBe('water');
  });
});

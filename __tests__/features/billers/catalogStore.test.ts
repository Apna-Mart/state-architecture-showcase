import { createAppContainer } from '@/core/container/appContainer';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { categoryById } from '@/features/billers/data/billerCatalog';

describe('CatalogStore', () => {
  it('loads then becomes data with 15 categories', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    c.catalog.getState().ensureLoaded();
    await c.catalog.getState().whenSettled();
    const state = c.catalog.getState().catalog;
    expect(state.status).toBe('data');
    if (state.status === 'data') expect(state.value.categories.length).toBe(15);
  });

  it('refreshIfStale within 30 min is a no-op, past 30 min refetches', async () => {
    let now = new Date('2026-06-05T10:00:00.000Z');
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }), clock: () => now });
    c.catalog.getState().ensureLoaded();
    await c.catalog.getState().whenSettled();
    let notifications = 0;
    const unsub = c.catalog.subscribe(() => { notifications += 1; });
    now = new Date(now.getTime() + 10 * 60_000);
    c.catalog.getState().refreshIfStale();
    await c.catalog.getState().whenSettled();
    expect(notifications).toBe(0);
    now = new Date(now.getTime() + 21 * 60_000);
    c.catalog.getState().refreshIfStale();
    await c.catalog.getState().whenSettled();
    expect(notifications).toBeGreaterThan(0);
    unsub();
  });

  it('refetches catalog content in the new language on language switch', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    c.catalog.getState().ensureLoaded();
    await c.catalog.getState().whenSettled();
    const english = c.catalog.getState().catalog;
    expect(english.status).toBe('data');
    if (english.status === 'data') {
      expect(categoryById(english.value, 'electricity')?.name).toBe('Electricity');
    }
    await c.settings.getState().setLocale('hi');
    await c.catalog.getState().whenSettled();
    const hindi = c.catalog.getState().catalog;
    expect(hindi.status).toBe('data');
    if (hindi.status === 'data') {
      expect(categoryById(hindi.value, 'electricity')?.name).toBe('बिजली');
    }
  });
});

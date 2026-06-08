import { createAppContainer } from '@/core/container/appContainer';
import { MockNetwork } from '@/core/mock/mockNetwork';

describe('language switch', () => {
  it('setting ar override resolves the locale language to ar', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    await c.settings.getState().setLocale('ar');
    expect(c.locale.getState().language).toBe('ar');
  });
  it('clearing the override falls back to a supported device language or en', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    await c.settings.getState().setLocale('hi');
    await c.settings.getState().setLocale(null);
    expect(['en', 'hi', 'ar']).toContain(c.locale.getState().language);
  });
});

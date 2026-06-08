import { createAppContainer } from '@/core/container/appContainer';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';

describe('SettingsStore', () => {
  it('hydrates from the repository and persists locale + theme changes', async () => {
    const store = new InMemoryKeyValueStore();
    const c = createAppContainer({ keyValueStore: store });
    expect(c.settings.getState().settings).toEqual({ localeOverride: null, themeMode: 'system' });
    await c.settings.getState().setLocale('ar');
    expect(c.settings.getState().settings.localeOverride).toBe('ar');
    expect(store.read('settings.locale')).toBe('ar');
    await c.settings.getState().setThemeMode('dark');
    expect(store.read('settings.themeMode')).toBe('dark');
  });

  it('locale change flows into the locale store language', async () => {
    const c = createAppContainer();
    await c.settings.getState().setLocale('hi');
    expect(c.locale.getState().language).toBe('hi');
  });
});

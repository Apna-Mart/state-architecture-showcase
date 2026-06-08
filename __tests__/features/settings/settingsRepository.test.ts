import { StoredSettingsRepository } from '@/features/settings/data/settingsRepository';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';

describe('StoredSettingsRepository', () => {
  it('defaults to system theme and no override on empty store', () => {
    const repo = new StoredSettingsRepository(new InMemoryKeyValueStore());
    expect(repo.restore()).toEqual({ localeOverride: null, themeMode: 'system' });
  });
  it('hydrates stored locale and theme, ignoring unsupported values', async () => {
    const store = new InMemoryKeyValueStore();
    await store.write('settings.locale', 'hi');
    await store.write('settings.themeMode', 'dark');
    expect(new StoredSettingsRepository(store).restore()).toEqual({ localeOverride: 'hi', themeMode: 'dark' });
    await store.write('settings.locale', 'xx');
    await store.write('settings.themeMode', 'neon');
    expect(new StoredSettingsRepository(store).restore()).toEqual({ localeOverride: null, themeMode: 'system' });
  });
  it('saveLocale null removes the key', async () => {
    const store = new InMemoryKeyValueStore();
    const repo = new StoredSettingsRepository(store);
    await repo.saveLocale('ar');
    expect(store.read('settings.locale')).toBe('ar');
    await repo.saveLocale(null);
    expect(store.read('settings.locale')).toBeNull();
  });
});

import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';
import { StoredSettingsRepository } from '@/features/settings/data/settingsRepository';
import { createSettingsStore } from '@/features/settings/data/settingsStore';

const make = () => {
  const store = new InMemoryKeyValueStore();
  return { store, settings: createSettingsStore({ settingsRepository: new StoredSettingsRepository(store) }) };
};

test('setLocale updates state and persists', () => {
  const { store, settings } = make();
  settings.getState().setLocale('hi');
  expect(settings.getState().settings.localeOverride).toBe('hi');
  expect(store.read('settings.locale')).toBe('hi');
});

test('setLocale null clears the persisted override', () => {
  const { store, settings } = make();
  settings.getState().setLocale('ar');
  settings.getState().setLocale(null);
  expect(settings.getState().settings.localeOverride).toBeNull();
  expect(store.read('settings.locale')).toBeNull();
});

test('setThemeMode updates state and persists', () => {
  const { store, settings } = make();
  settings.getState().setThemeMode('dark');
  expect(settings.getState().settings.themeMode).toBe('dark');
  expect(store.read('settings.themeMode')).toBe('dark');
});

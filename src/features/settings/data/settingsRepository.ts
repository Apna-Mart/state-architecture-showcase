import type { KeyValueStore } from '../../../core/storage/keyValueStore';
import { localeConfigs } from '../../../core/format/localeConfig';
import { defaultSettings, type AppSettings, type ThemeModeSetting } from './appSettings';

const LOCALE_KEY = 'settings.locale';
const THEME_KEY = 'settings.themeMode';
const THEME_MODES: readonly ThemeModeSetting[] = ['system', 'light', 'dark'];

export interface SettingsRepository {
  restore(): AppSettings;
  saveLocale(locale: string | null): Promise<void>;
  saveThemeMode(mode: ThemeModeSetting): Promise<void>;
}

export class StoredSettingsRepository implements SettingsRepository {
  constructor(private readonly store: KeyValueStore) {}

  restore(): AppSettings {
    const language = this.store.read(LOCALE_KEY);
    const themeName = this.store.read(THEME_KEY);
    const localeOverride = language !== null && language in localeConfigs ? language : null;
    const themeMode = THEME_MODES.find((m) => m === themeName) ?? 'system';
    return { ...defaultSettings(), localeOverride, themeMode };
  }

  saveLocale(locale: string | null): Promise<void> {
    return locale === null ? this.store.remove(LOCALE_KEY) : this.store.write(LOCALE_KEY, locale);
  }

  saveThemeMode(mode: ThemeModeSetting): Promise<void> {
    return this.store.write(THEME_KEY, mode);
  }
}

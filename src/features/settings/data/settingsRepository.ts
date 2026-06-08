import { isSupportedLanguage, type SupportedLanguage } from '@/core/format/localeConfigs';
import type { KeyValueStore } from '@/core/storage/keyValueStore';
import { type AppSettings, type ThemeMode } from './appSettings';

const localeKey = 'settings.locale';
const themeModeKey = 'settings.themeMode';
const themeModes: ThemeMode[] = ['system', 'light', 'dark'];

export interface SettingsRepository {
  restore(): AppSettings;
  saveLocale(language: SupportedLanguage | null): void;
  saveThemeMode(mode: ThemeMode): void;
}

export class StoredSettingsRepository implements SettingsRepository {
  constructor(private readonly store: KeyValueStore) {}

  restore(): AppSettings {
    const language = this.store.read(localeKey);
    const themeName = this.store.read(themeModeKey);
    return {
      localeOverride: language !== null && isSupportedLanguage(language) ? language : null,
      themeMode: themeName !== null && themeModes.includes(themeName as ThemeMode) ? (themeName as ThemeMode) : 'system',
    };
  }

  saveLocale(language: SupportedLanguage | null): void {
    if (language === null) this.store.remove(localeKey);
    else this.store.write(localeKey, language);
  }

  saveThemeMode(mode: ThemeMode): void {
    this.store.write(themeModeKey, mode);
  }
}

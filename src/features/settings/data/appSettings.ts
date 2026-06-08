import type { SupportedLanguage } from '@/core/format/localeConfigs';

export type ThemeMode = 'system' | 'light' | 'dark';

export type AppSettings = {
  localeOverride: SupportedLanguage | null;
  themeMode: ThemeMode;
};

export const defaultSettings = (): AppSettings => ({ localeOverride: null, themeMode: 'system' });

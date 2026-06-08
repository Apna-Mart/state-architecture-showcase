export type ThemeModeSetting = 'system' | 'light' | 'dark';

export interface AppSettings {
  readonly localeOverride: string | null;
  readonly themeMode: ThemeModeSetting;
}

export const defaultSettings = (): AppSettings => ({ localeOverride: null, themeMode: 'system' });

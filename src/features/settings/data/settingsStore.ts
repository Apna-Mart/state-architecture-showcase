import { createStore, type StoreApi } from 'zustand/vanilla';
import type { AppContainer } from '../../../core/container/appContainer';
import type { AppSettings, ThemeModeSetting } from './appSettings';

export interface SettingsState {
  readonly settings: AppSettings;
  setLocale(locale: string | null): Promise<void>;
  setThemeMode(mode: ThemeModeSetting): Promise<void>;
}

export type SettingsStore = StoreApi<SettingsState>;

export const createSettingsStore = (getContainer: () => AppContainer): SettingsStore =>
  createStore<SettingsState>((set, get) => ({
    settings: getContainer().settingsRepository.restore(),
    setLocale: async (locale) => {
      set({ settings: { ...get().settings, localeOverride: locale } });
      await getContainer().settingsRepository.saveLocale(locale);
    },
    setThemeMode: async (mode) => {
      set({ settings: { ...get().settings, themeMode: mode } });
      await getContainer().settingsRepository.saveThemeMode(mode);
    },
  }));

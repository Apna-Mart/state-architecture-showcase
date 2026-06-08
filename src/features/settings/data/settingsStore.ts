import { createStore } from 'zustand/vanilla';
import type { SupportedLanguage } from '@/core/format/localeConfigs';
import type { AppSettings, ThemeMode } from './appSettings';
import type { SettingsRepository } from './settingsRepository';

type Deps = { settingsRepository: SettingsRepository };

export type SettingsState = {
  settings: AppSettings;
  setLocale(language: SupportedLanguage | null): void;
  setThemeMode(mode: ThemeMode): void;
};

export const createSettingsStore = (deps: Deps) =>
  createStore<SettingsState>((set, get) => ({
    settings: deps.settingsRepository.restore(),
    setLocale: (language) => {
      set({ settings: { ...get().settings, localeOverride: language } });
      deps.settingsRepository.saveLocale(language);
    },
    setThemeMode: (mode) => {
      set({ settings: { ...get().settings, themeMode: mode } });
      deps.settingsRepository.saveThemeMode(mode);
    },
  }));

export type SettingsStore = ReturnType<typeof createSettingsStore>;

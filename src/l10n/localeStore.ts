import { createStore, type StoreApi } from 'zustand/vanilla';
import { NativeModules, Platform } from 'react-native';
import { localeConfigs } from '../core/format/localeConfig';
import type { AppContainer } from '../core/container/appContainer';

const deviceLanguage = (): string => {
  const raw =
    Platform.OS === 'ios'
      ? (NativeModules.SettingsManager?.settings?.AppleLocale ??
         NativeModules.SettingsManager?.settings?.AppleLanguages?.[0] ??
         'en')
      : (NativeModules.I18nManager?.localeIdentifier ?? 'en');
  return String(raw).slice(0, 2);
};

export interface LocaleState {
  readonly deviceLanguage: string;
  readonly language: string;
  setDeviceLanguage(language: string): void;
  recompute(): void;
}

export type LocaleStore = StoreApi<LocaleState>;

export const createLocaleStore = (getContainer: () => AppContainer): LocaleStore => {
  const resolve = (device: string, override: string | null): string => {
    if (override !== null && override in localeConfigs) return override;
    return device in localeConfigs ? device : 'en';
  };
  const device = deviceLanguage();
  const store = createStore<LocaleState>((set, get) => ({
    deviceLanguage: device,
    language: resolve(device, getContainer().settings.getState().settings.localeOverride),
    setDeviceLanguage: (language) =>
      set({
        deviceLanguage: language,
        language: resolve(language, getContainer().settings.getState().settings.localeOverride),
      }),
    recompute: () =>
      set({
        language: resolve(get().deviceLanguage, getContainer().settings.getState().settings.localeOverride),
      }),
  }));
  getContainer().settings.subscribe(() => store.getState().recompute());
  return store;
};

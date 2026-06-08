import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import ICU from 'i18next-icu';
import en from './en.json';
import hi from './hi.json';
import ar from './ar.json';
import { isSupportedLanguage, type SupportedLanguage } from '@/core/format/localeConfigs';

export function resolveLanguage(override: SupportedLanguage | null, deviceCode: string): SupportedLanguage {
  if (override !== null) return override;
  return isSupportedLanguage(deviceCode) ? deviceCode : 'en';
}

export const i18nResources = { en: { translation: en }, hi: { translation: hi }, ar: { translation: ar } };

export function createI18n(language: SupportedLanguage) {
  const instance = i18n.createInstance();
  instance
    .use(ICU)
    .use(initReactI18next)
    .init({
      resources: i18nResources,
      lng: language,
      fallbackLng: 'en',
      interpolation: { escapeValue: false },
      returnNull: false,
    });
  return instance;
}

import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import ICU from 'i18next-icu';
import en from './en.json';
import hi from './hi.json';
import ar from './ar.json';

export const createI18n = (language: string): typeof i18n => {
  const instance = i18n.createInstance();
  void instance
    .use(ICU)
    .use(initReactI18next)
    .init({
      resources: { en: { translation: en }, hi: { translation: hi }, ar: { translation: ar } },
      lng: language,
      fallbackLng: 'en',
      interpolation: { escapeValue: false },
    });
  return instance;
};

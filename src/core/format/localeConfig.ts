export interface LocaleConfig {
  readonly numberLocale: string;
  readonly dateLocale: string;
  readonly currencySymbol: string;
}

export const localeConfigs: Readonly<Record<string, LocaleConfig>> = {
  en: { numberLocale: 'en-IN', dateLocale: 'en', currencySymbol: '₹' },
  hi: { numberLocale: 'hi', dateLocale: 'hi', currencySymbol: '₹' },
  ar: { numberLocale: 'ar-EG', dateLocale: 'ar-EG', currencySymbol: '₹' },
};

export const supportedLanguages = ['en', 'hi', 'ar'] as const;
export type SupportedLanguage = (typeof supportedLanguages)[number];

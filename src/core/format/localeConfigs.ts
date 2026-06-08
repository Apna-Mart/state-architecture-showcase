export type SupportedLanguage = 'en' | 'hi' | 'ar';

export type LocaleConfig = {
  numberLocale: string;
  dateLocale: string;
  currencySymbol: string;
};

export const localeConfigs: Record<SupportedLanguage, LocaleConfig> = {
  en: { numberLocale: 'en-IN', dateLocale: 'en-IN', currencySymbol: '₹' },
  hi: { numberLocale: 'hi-IN', dateLocale: 'hi-IN', currencySymbol: '₹' },
  ar: { numberLocale: 'ar-EG', dateLocale: 'ar-EG', currencySymbol: '₹' },
};

export const supportedLanguages = Object.keys(localeConfigs) as SupportedLanguage[];

export const isSupportedLanguage = (value: string): value is SupportedLanguage =>
  value in localeConfigs;

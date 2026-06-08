import { localeConfigs, type LocaleConfig } from './localeConfig';

const fallbackConfig: LocaleConfig = { numberLocale: 'en-IN', dateLocale: 'en', currencySymbol: '₹' };

const configFor = (locale: string): LocaleConfig => localeConfigs[locale] ?? fallbackConfig;

export const formatPaise = (paise: number, locale: string): string => {
  const config = configFor(locale);
  const amount = new Intl.NumberFormat(config.numberLocale, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(paise / 100);
  return `${config.currencySymbol}${amount}`;
};

export const formatDate = (date: Date, locale: string): string => {
  const parts = new Intl.DateTimeFormat(configFor(locale).dateLocale, {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
  }).formatToParts(date);
  const valueOf = (type: Intl.DateTimeFormatPartTypes): string =>
    parts.find((part) => part.type === type)?.value ?? '';
  return `${valueOf('day')} ${valueOf('month')} ${valueOf('year')}`;
};

const atMidnight = (d: Date): number =>
  new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime();

export const daysUntilDue = (due: Date, now: Date): number =>
  Math.round((atMidnight(due) - atMidnight(now)) / 86_400_000);

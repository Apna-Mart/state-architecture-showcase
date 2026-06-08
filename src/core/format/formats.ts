import { localeConfigs, isSupportedLanguage, type SupportedLanguage } from './localeConfigs';

const configFor = (language: string): SupportedLanguage =>
  isSupportedLanguage(language) ? language : 'en';

export function formatPaise(paise: number, language: string): string {
  const config = localeConfigs[configFor(language)];
  const formatted = new Intl.NumberFormat(config.numberLocale, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(paise / 100);
  return `${config.currencySymbol}${formatted}`;
}

const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

export function formatDate(date: Date, language: string): string {
  const config = localeConfigs[configFor(language)];
  if (configFor(language) === 'en') {
    return `${date.getDate()} ${months[date.getMonth()]} ${date.getFullYear()}`;
  }
  return new Intl.DateTimeFormat(config.dateLocale, {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
  }).format(date);
}

export function daysUntilDue(due: Date, now: Date): number {
  const dueDay = Date.UTC(due.getFullYear(), due.getMonth(), due.getDate());
  const nowDay = Date.UTC(now.getFullYear(), now.getMonth(), now.getDate());
  return Math.round((dueDay - nowDay) / 86_400_000);
}

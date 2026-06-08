import type { TFunction } from 'i18next';

export function dueLabel(t: TFunction, days: number): string {
  if (days < 0) return t('overdueByDays', { days: -days });
  if (days === 0) return t('dueToday');
  return t('dueInDays', { days });
}

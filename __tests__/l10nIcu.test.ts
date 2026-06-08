import { createI18n } from '@/l10n/i18n';

describe('i18next-icu', () => {
  it('interpolates named params', () => {
    const i18n = createI18n('en');
    expect(i18n.t('otpSentTo', { phone: '9876543210' })).toBe('OTP sent to 9876543210');
  });
  it('selects plural forms', () => {
    const i18n = createI18n('en');
    expect(i18n.t('dueInDays', { days: 1 })).toBe('Due in 1 day');
    expect(i18n.t('dueInDays', { days: 3 })).toBe('Due in 3 days');
  });
});

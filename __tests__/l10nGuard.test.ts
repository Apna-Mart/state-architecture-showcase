import en from '@/l10n/en.json';
import hi from '@/l10n/hi.json';
import ar from '@/l10n/ar.json';
import { localeConfigs, supportedLanguages } from '@/core/format/localeConfig';

describe('l10n guard', () => {
  it('all locales share the exact same key set', () => {
    const enKeys = Object.keys(en).sort();
    expect(Object.keys(hi).sort()).toEqual(enKeys);
    expect(Object.keys(ar).sort()).toEqual(enKeys);
  });
  it('localeConfigs rows match the supported locales', () => {
    expect(Object.keys(localeConfigs).sort()).toEqual([...supportedLanguages].sort());
  });
  it('has the 54 expected keys including the two plurals', () => {
    expect(Object.keys(en).length).toBe(54);
    expect(en).toHaveProperty('dueInDays');
    expect(en).toHaveProperty('overdueByDays');
  });
});

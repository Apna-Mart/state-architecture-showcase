import en from '@/l10n/en.json';
import hi from '@/l10n/hi.json';
import ar from '@/l10n/ar.json';
import { localeConfigs, supportedLanguages } from '@/core/format/localeConfigs';
import { i18nResources } from '@/l10n/i18n';

test('all three locales expose exactly 54 keys', () => {
  expect(Object.keys(en)).toHaveLength(54);
  expect(Object.keys(hi)).toHaveLength(54);
  expect(Object.keys(ar)).toHaveLength(54);
});

test('key sets are identical across locales', () => {
  const keys = (o: object) => Object.keys(o).sort();
  expect(keys(hi)).toEqual(keys(en));
  expect(keys(ar)).toEqual(keys(en));
});

test('localeConfigs covers exactly the bundled i18n languages', () => {
  expect(Object.keys(localeConfigs).sort()).toEqual(Object.keys(i18nResources).sort());
  expect(supportedLanguages.sort()).toEqual(['ar', 'en', 'hi']);
});

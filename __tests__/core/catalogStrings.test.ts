import { categoryNames, providerPrefixes, paramLabels, paramHints } from '@/features/billers/data/catalogStrings';

test('catalog string maps have the expected key counts and all three locales', () => {
  expect(Object.keys(categoryNames)).toHaveLength(15);
  expect(Object.keys(providerPrefixes)).toHaveLength(4);
  expect(Object.keys(paramLabels)).toHaveLength(10);
  expect(Object.keys(paramHints)).toHaveLength(2);
  for (const map of [categoryNames, providerPrefixes, paramLabels, paramHints]) {
    for (const value of Object.values(map)) {
      expect(Object.keys(value).sort()).toEqual(['ar', 'en', 'hi']);
    }
  }
});

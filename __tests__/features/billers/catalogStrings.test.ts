import { categoryNames, providerPrefixes, paramLabels, paramHints } from '@/features/billers/data/catalogStrings';

describe('catalogStrings', () => {
  it('has 15 categories, 4 prefixes, 10 labels, 2 hints, each with en/hi/ar', () => {
    expect(Object.keys(categoryNames).length).toBe(15);
    expect(Object.keys(providerPrefixes).length).toBe(4);
    expect(Object.keys(paramLabels).length).toBe(10);
    expect(Object.keys(paramHints).length).toBe(2);
    for (const map of [categoryNames, providerPrefixes, paramLabels, paramHints]) {
      for (const value of Object.values(map)) {
        expect(value.en).toBeTruthy();
        expect(value.hi).toBeTruthy();
        expect(value.ar).toBeTruthy();
      }
    }
  });
});

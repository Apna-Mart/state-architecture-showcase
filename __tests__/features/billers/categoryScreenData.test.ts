import { projectCategory } from '@/features/billers/ui/categoryScreenData';
import { asyncData, asyncError, asyncLoading } from '@/core/async/async';
import { makeCatalog } from '@/features/billers/data/billerCatalog';

const catalog = makeCatalog(
  [{ id: 'water', name: 'Water' }],
  [
    { id: 'water-metro', categoryId: 'water', name: 'Metro Water', mode: 'presentment', inputParams: [] },
    { id: 'water-city', categoryId: 'water', name: 'City Water', mode: 'presentment', inputParams: [] },
  ],
);

describe('projectCategory', () => {
  it('loading while catalog loads', () => {
    expect(projectCategory(asyncLoading(), 'water')).toEqual({ kind: 'loading' });
  });
  it('error surfaces a message', () => {
    expect(projectCategory(asyncError(new Error('down')), 'water').kind).toBe('error');
  });
  it('loaded lists the category billers with category names', () => {
    const result = projectCategory(asyncData(catalog), 'water');
    expect(result).toEqual({
      kind: 'loaded', categoryName: 'Water',
      billers: [
        { id: 'water-metro', name: 'Metro Water', categoryName: 'Water' },
        { id: 'water-city', name: 'City Water', categoryName: 'Water' },
      ],
    });
  });
  it('unknown category is an error', () => {
    expect(projectCategory(asyncData(catalog), 'nope').kind).toBe('error');
  });
});

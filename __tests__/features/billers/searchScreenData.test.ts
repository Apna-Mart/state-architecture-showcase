import { projectSearch } from '@/features/billers/ui/searchScreenData';
import { asyncData, asyncError, asyncLoading } from '@/core/async/async';
import { makeCatalog } from '@/features/billers/data/billerCatalog';

const catalog = asyncData(makeCatalog(
  [{ id: 'electricity', name: 'Electricity' }],
  [{ id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [] }],
));

describe('projectSearch', () => {
  it('short query is idle', () => {
    expect(projectSearch('m', undefined, catalog)).toEqual({ kind: 'idle' });
  });
  it('undefined result while querying is searching', () => {
    expect(projectSearch('metro', undefined, catalog)).toEqual({ kind: 'searching' });
    expect(projectSearch('metro', asyncLoading(), catalog)).toEqual({ kind: 'searching' });
  });
  it('empty data is empty(query)', () => {
    expect(projectSearch('zzzz', asyncData([]), catalog)).toEqual({ kind: 'empty', query: 'zzzz' });
  });
  it('error is error(query)', () => {
    expect(projectSearch('metro', asyncError(new Error('x')), catalog)).toEqual({ kind: 'error', query: 'metro' });
  });
  it('data maps to results with category names', () => {
    const result = projectSearch('metro', asyncData([{ id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [] }]), catalog);
    expect(result).toEqual({ kind: 'results', billers: [{ id: 'electricity-metro', name: 'Metro Electricity', categoryName: 'Electricity' }] });
  });
});

import { makeCatalog, billersFor, billerById, categoryById } from '@/features/billers/data/billerCatalog';
import type { Biller, BillerCategory } from '@/features/billers/data/biller';

const categories: BillerCategory[] = [{ id: 'electricity', name: 'Electricity' }];
const billers: Biller[] = [
  { id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [] },
  { id: 'electricity-city', categoryId: 'electricity', name: 'City Electricity', mode: 'presentment', inputParams: [] },
];

describe('BillerCatalog', () => {
  const catalog = makeCatalog(categories, billers);
  it('billersFor filters by category', () => {
    expect(billersFor(catalog, 'electricity').length).toBe(2);
    expect(billersFor(catalog, 'water').length).toBe(0);
  });
  it('billerById and categoryById return null when missing', () => {
    expect(billerById(catalog, 'electricity-metro')?.name).toBe('Metro Electricity');
    expect(billerById(catalog, 'nope')).toBeNull();
    expect(categoryById(catalog, 'electricity')?.name).toBe('Electricity');
    expect(categoryById(catalog, 'nope')).toBeNull();
  });
});

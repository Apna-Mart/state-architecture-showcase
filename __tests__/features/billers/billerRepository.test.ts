import { FakeBillerRepository } from '@/features/billers/data/billerRepository';
import { MockNetwork } from '@/core/mock/mockNetwork';

const repo = () => new FakeBillerRepository(new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }));

describe('FakeBillerRepository', () => {
  it('catalog has 15 categories, 60 billers, 4 per category', async () => {
    const catalog = await repo().fetchCatalog('en');
    expect(catalog.categories.length).toBe(15);
    expect(catalog.billers.length).toBe(60);
    expect(catalog.billers.filter((b) => b.categoryId === 'electricity').length).toBe(4);
  });
  it('dth is openAmount, electricity is presentment, credit-card has two params', async () => {
    const catalog = await repo().fetchCatalog('en');
    expect(catalog.billers.find((b) => b.id === 'dth-metro')!.mode).toBe('openAmount');
    expect(catalog.billers.find((b) => b.id === 'electricity-metro')!.mode).toBe('presentment');
    expect(catalog.billers.find((b) => b.id === 'credit-card-city')!.inputParams.length).toBe(2);
  });
  it('search matches names case-insensitively', async () => {
    const results = await repo().search('metro elec', 'en');
    expect(results.length).toBe(1);
    expect(results[0]!.id).toBe('electricity-metro');
  });
  it('arabic billerName puts category before prefix', async () => {
    const catalog = await repo().fetchCatalog('ar');
    const biller = catalog.billers.find((b) => b.id === 'electricity-metro')!;
    expect(biller.name).toBe('الكهرباء مترو');
  });
});

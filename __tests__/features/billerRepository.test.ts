import { MockNetwork } from '@/core/mock/mockNetwork';
import { FakeBillerRepository } from '@/features/billers/data/billerRepository';

const repo = () => new FakeBillerRepository(new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }));

test('catalog has 15 categories and 60 billers', async () => {
  const catalog = await repo().fetchCatalog('en');
  expect(catalog.categories).toHaveLength(15);
  expect(catalog.billers).toHaveLength(60);
});

test('open-amount categories produce openAmount billers, others presentment', async () => {
  const catalog = await repo().fetchCatalog('en');
  const prepaid = catalog.billers.find((b) => b.categoryId === 'mobile-prepaid')!;
  const electricity = catalog.billers.find((b) => b.categoryId === 'electricity')!;
  expect(prepaid.mode).toBe('openAmount');
  expect(electricity.mode).toBe('presentment');
});

test('credit-card billers have two input params', async () => {
  const catalog = await repo().fetchCatalog('en');
  const card = catalog.billers.find((b) => b.categoryId === 'credit-card')!;
  expect(card.inputParams).toHaveLength(2);
});

test('search is case-insensitive substring on name', async () => {
  const results = await repo().search('metro electric', 'en');
  expect(results.length).toBeGreaterThan(0);
  expect(results.every((b) => b.name.toLowerCase().includes('metro electric'))).toBe(true);
});

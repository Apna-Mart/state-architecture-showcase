import { projectSearch } from '@/features/billers/ui/searchProjection';
import { projectCategory } from '@/features/billers/ui/categoryProjection';
import type { BillerCatalog } from '@/features/billers/data/biller';

const catalog: BillerCatalog = {
  categories: [{ id: 'water', name: 'Water' }],
  billers: [{ id: 'water-city', categoryId: 'water', name: 'City Water', mode: 'presentment', inputParams: [] }],
};

test('search under 2 chars is idle', () => {
  expect(projectSearch('a', { status: 'loading' }, undefined).kind).toBe('idle');
});
test('search results map to list items with category name', () => {
  const data = projectSearch('water', { status: 'data', value: catalog.billers }, catalog);
  expect(data).toEqual({ kind: 'results', billers: [{ id: 'water-city', name: 'City Water', categoryName: 'Water' }] });
});
test('search with no matches is empty', () => {
  expect(projectSearch('water', { status: 'data', value: [] }, catalog)).toEqual({ kind: 'empty', query: 'water' });
});
test('search error surfaces error with query', () => {
  expect(projectSearch('water', { status: 'error', error: new Error('x') }, catalog)).toEqual({ kind: 'error', query: 'water' });
});
test('search pending is searching', () => {
  expect(projectSearch('water', { status: 'loading' }, catalog).kind).toBe('searching');
});

test('category loaded lists billers', () => {
  const data = projectCategory('water', { status: 'data', value: catalog });
  expect(data).toEqual({ kind: 'loaded', categoryName: 'Water', billers: [{ id: 'water-city', name: 'City Water', categoryName: 'Water' }] });
});
test('category not found is error', () => {
  expect(projectCategory('missing', { status: 'data', value: catalog }).kind).toBe('error');
});
test('category pending is loading', () => {
  expect(projectCategory('water', { status: 'loading' }).kind).toBe('loading');
});

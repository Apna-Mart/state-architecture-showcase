import { assertNever, type Async } from '@/core/async/async';
import { billersFor, categoryById, type BillerCatalog } from '../data/biller';
import type { CategoryScreenData } from './categoryScreenData';

export function projectCategory(categoryId: string, catalog: Async<BillerCatalog>): CategoryScreenData {
  switch (catalog.status) {
    case 'data': {
      const category = categoryById(catalog.value, categoryId);
      if (category === undefined) return { kind: 'error', message: 'Category not found' };
      return {
        kind: 'loaded',
        categoryName: category.name,
        billers: billersFor(catalog.value, categoryId).map((b) => ({ id: b.id, name: b.name, categoryName: category.name })),
      };
    }
    case 'error':
      return { kind: 'error', message: String(catalog.error) };
    case 'loading':
      return { kind: 'loading' };
    default:
      return assertNever(catalog);
  }
}

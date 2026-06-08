import { assertNever, type Async } from '@/core/async/async';
import { categoryById, type Biller, type BillerCatalog } from '../data/biller';
import type { SearchScreenData } from './searchScreenData';

export function projectSearch(query: string, results: Async<Biller[]>, catalog: BillerCatalog | undefined): SearchScreenData {
  if (query.trim().length < 2) return { kind: 'idle' };
  switch (results.status) {
    case 'data':
      return results.value.length === 0
        ? { kind: 'empty', query }
        : {
            kind: 'results',
            billers: results.value.map((b) => ({
              id: b.id,
              name: b.name,
              categoryName: catalog ? categoryById(catalog, b.categoryId)?.name ?? '' : '',
            })),
          };
    case 'error':
      return { kind: 'error', query };
    case 'loading':
      return { kind: 'searching' };
    default:
      return assertNever(results);
  }
}

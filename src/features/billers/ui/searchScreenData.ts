import { useStore } from 'zustand';
import type { BillerListItemData } from './billerListItemData';
import { type Async, asyncValueOrNull } from '../../../core/async/async';
import { categoryById, type BillerCatalog } from '../data/billerCatalog';
import type { Biller } from '../data/biller';
import { useContainer } from '../../../core/container/containerContext';

export type SearchScreenData =
  | { readonly kind: 'idle' }
  | { readonly kind: 'searching' }
  | { readonly kind: 'empty'; readonly query: string }
  | { readonly kind: 'error'; readonly query: string }
  | { readonly kind: 'results'; readonly billers: readonly BillerListItemData[] };

export const projectSearch = (
  query: string,
  result: Async<readonly Biller[]> | undefined,
  catalog: Async<BillerCatalog>,
): SearchScreenData => {
  if (query.trim().length < 2) return { kind: 'idle' };
  if (result === undefined || result.status === 'loading') return { kind: 'searching' };
  if (result.status === 'error') return { kind: 'error', query };
  const cat = asyncValueOrNull(catalog);
  if (result.value.length === 0) return { kind: 'empty', query };
  return {
    kind: 'results',
    billers: result.value.map((b) => ({
      id: b.id,
      name: b.name,
      categoryName: cat ? (categoryById(cat, b.categoryId)?.name ?? '') : '',
    })),
  };
};

export const useSearchScreenData = (): SearchScreenData => {
  const container = useContainer();
  const query = useStore(container.search, (s) => s.query);
  const result = useStore(container.search, (s) => s.results[query]);
  const catalog = useStore(container.catalog, (s) => s.catalog);
  return projectSearch(query, result, catalog);
};

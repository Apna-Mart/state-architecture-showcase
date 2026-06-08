import { useStore } from 'zustand';
import type { BillerListItemData } from './billerListItemData';
import { type Async } from '../../../core/async/async';
import { billersFor, categoryById, type BillerCatalog } from '../data/billerCatalog';
import { useContainer } from '../../../core/container/containerContext';

export type CategoryScreenData =
  | { readonly kind: 'loading' }
  | { readonly kind: 'error'; readonly message: string }
  | { readonly kind: 'loaded'; readonly categoryName: string; readonly billers: readonly BillerListItemData[] };

export const projectCategory = (catalog: Async<BillerCatalog>, categoryId: string): CategoryScreenData => {
  if (catalog.status === 'loading') return { kind: 'loading' };
  if (catalog.status === 'error') return { kind: 'error', message: String(catalog.error) };
  const category = categoryById(catalog.value, categoryId);
  if (category === null) return { kind: 'error', message: 'Category not found' };
  return {
    kind: 'loaded',
    categoryName: category.name,
    billers: billersFor(catalog.value, categoryId).map((b) => ({
      id: b.id, name: b.name, categoryName: category.name,
    })),
  };
};

export const useCategoryScreenData = (categoryId: string): CategoryScreenData => {
  const container = useContainer();
  const catalog = useStore(container.catalog, (s) => s.catalog);
  return projectCategory(catalog, categoryId);
};

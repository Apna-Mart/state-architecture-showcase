import type { Biller, BillerCategory } from './biller';

export interface BillerCatalog {
  readonly categories: readonly BillerCategory[];
  readonly billers: readonly Biller[];
}

export const makeCatalog = (
  categories: readonly BillerCategory[],
  billers: readonly Biller[],
): BillerCatalog => ({ categories, billers });

export const billersFor = (catalog: BillerCatalog, categoryId: string): readonly Biller[] =>
  catalog.billers.filter((b) => b.categoryId === categoryId);

export const billerById = (catalog: BillerCatalog, id: string): Biller | null =>
  catalog.billers.find((b) => b.id === id) ?? null;

export const categoryById = (catalog: BillerCatalog, id: string): BillerCategory | null =>
  catalog.categories.find((c) => c.id === id) ?? null;

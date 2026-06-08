export type BillerMode = 'presentment' | 'openAmount';

export type BillerCategory = { id: string; name: string };

export type BillerInputParam = { key: string; label: string; hint: string };

export type Biller = {
  id: string;
  categoryId: string;
  name: string;
  mode: BillerMode;
  inputParams: BillerInputParam[];
};

export type BillerCatalog = {
  categories: BillerCategory[];
  billers: Biller[];
};

export const billersFor = (catalog: BillerCatalog, categoryId: string): Biller[] =>
  catalog.billers.filter((b) => b.categoryId === categoryId);

export const billerById = (catalog: BillerCatalog, id: string): Biller | undefined =>
  catalog.billers.find((b) => b.id === id);

export const categoryById = (catalog: BillerCatalog, id: string): BillerCategory | undefined =>
  catalog.categories.find((c) => c.id === id);

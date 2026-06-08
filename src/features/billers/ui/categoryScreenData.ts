import type { BillerListItemData } from './billerListItemData';

export type CategoryScreenData =
  | { kind: 'loading' }
  | { kind: 'error'; message: string }
  | { kind: 'loaded'; categoryName: string; billers: BillerListItemData[] };

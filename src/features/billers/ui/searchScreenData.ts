import type { BillerListItemData } from './billerListItemData';

export type SearchScreenData =
  | { kind: 'idle' }
  | { kind: 'searching' }
  | { kind: 'empty'; query: string }
  | { kind: 'error'; query: string }
  | { kind: 'results'; billers: BillerListItemData[] };

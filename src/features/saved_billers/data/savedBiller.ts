export interface SavedBiller {
  readonly billerId: string;
  readonly account: string;
  readonly nickname: string;
}

export interface SavedBillers {
  readonly items: readonly SavedBiller[];
}

export const emptySavedBillers = (): SavedBillers => ({ items: [] });

export const contains = (saved: SavedBillers, billerId: string, account: string): boolean =>
  saved.items.some((s) => s.billerId === billerId && s.account === account);

export const addingSaved = (saved: SavedBillers, item: SavedBiller): SavedBillers => ({
  items: [...saved.items, item],
});

export const removingSaved = (saved: SavedBillers, billerId: string, account: string): SavedBillers => ({
  items: saved.items.filter((s) => s.billerId !== billerId || s.account !== account),
});

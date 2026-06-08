export type SavedBiller = { billerId: string; account: string; nickname: string };

export type SavedBillers = { items: SavedBiller[] };

export const emptySavedBillers = (): SavedBillers => ({ items: [] });

export const savedContains = (saved: SavedBillers, billerId: string, account: string): boolean =>
  saved.items.some((s) => s.billerId === billerId && s.account === account);

export const addingSaved = (saved: SavedBillers, entry: SavedBiller): SavedBillers => ({
  items: [...saved.items, entry],
});

export const removingSaved = (saved: SavedBillers, billerId: string, account: string): SavedBillers => ({
  items: saved.items.filter((s) => s.billerId !== billerId || s.account !== account),
});

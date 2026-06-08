export type CategoryItemData = { id: string; name: string; icon: string };
export type DueBillItemData = {
  billerId: string;
  account: string;
  billerName: string;
  amountPaise: number;
  dueInDays: number;
};
export type SavedBillerItemData = {
  billerId: string;
  account: string;
  nickname: string;
  billerName: string;
  openAmount: boolean;
};
export type HomeRemindersData =
  | { kind: 'loading' }
  | { kind: 'loaded'; items: DueBillItemData[] };
export type HomeSavedBillersData =
  | { kind: 'loading' }
  | { kind: 'loaded'; items: SavedBillerItemData[] };
export type HomeCategoriesData =
  | { kind: 'loading' }
  | { kind: 'error'; message: string }
  | { kind: 'loaded'; items: CategoryItemData[] };
export type HomeScreenData = {
  reminders: HomeRemindersData;
  savedBillers: HomeSavedBillersData;
  categories: HomeCategoriesData;
};

import { useStore } from 'zustand';
import { type Async, asyncValueOrNull } from '../../../core/async/async';
import { daysUntilDue } from '../../../core/format/formats';
import type { BillerCatalog } from '../../billers/data/billerCatalog';
import type { Biller } from '../../billers/data/biller';
import type { FetchedBill } from '../../bills/data/fetchedBill';
import type { SavedBillers } from '../../saved_billers/data/savedBiller';
import { categoryIcon } from './categoryIcons';
import { useContainer } from '../../../core/container/containerContext';

export interface CategoryItemData { readonly id: string; readonly name: string; readonly icon: string }
export interface DueBillItemData {
  readonly billerId: string; readonly account: string; readonly billerName: string;
  readonly amountPaise: number; readonly dueInDays: number;
}
export interface SavedBillerItemData {
  readonly billerId: string; readonly account: string; readonly nickname: string;
  readonly billerName: string; readonly openAmount: boolean;
}
export type HomeRemindersData =
  | { readonly kind: 'loading' }
  | { readonly kind: 'loaded'; readonly items: readonly DueBillItemData[] };
export type HomeSavedBillersData =
  | { readonly kind: 'loading' }
  | { readonly kind: 'loaded'; readonly items: readonly SavedBillerItemData[] };
export type HomeCategoriesData =
  | { readonly kind: 'loading' }
  | { readonly kind: 'error'; readonly message: string }
  | { readonly kind: 'loaded'; readonly items: readonly CategoryItemData[] };
export interface HomeScreenData {
  readonly reminders: HomeRemindersData;
  readonly savedBillers: HomeSavedBillersData;
  readonly categories: HomeCategoriesData;
}

export const projectHomeCategories = (catalog: Async<BillerCatalog>): HomeCategoriesData => {
  const value = asyncValueOrNull(catalog);
  if (value !== null) {
    return { kind: 'loaded', items: value.categories.map((c) => ({ id: c.id, name: c.name, icon: categoryIcon(c.id) })) };
  }
  if (catalog.status === 'error') return { kind: 'error', message: String(catalog.error) };
  return { kind: 'loading' };
};

export const projectHomeSavedBillers = (catalog: Async<BillerCatalog>, saved: SavedBillers): HomeSavedBillersData => {
  if (saved.items.length === 0) return { kind: 'loaded', items: [] };
  const value = asyncValueOrNull(catalog);
  if (value === null) return catalog.status === 'error' ? { kind: 'loaded', items: [] } : { kind: 'loading' };
  const byId = new Map(value.billers.map((b) => [b.id, b]));
  return {
    kind: 'loaded',
    items: saved.items.map((s) => ({
      billerId: s.billerId,
      account: s.account,
      nickname: s.nickname,
      billerName: byId.get(s.billerId)?.name ?? s.billerId,
      openAmount: byId.get(s.billerId)?.mode === 'openAmount',
    })),
  };
};

export const projectHomeReminders = (
  catalog: Async<BillerCatalog>,
  dueBills: Async<readonly FetchedBill[]>,
  saved: SavedBillers,
  now: Date,
): HomeRemindersData => {
  if (saved.items.length === 0) return { kind: 'loaded', items: [] };
  const value = asyncValueOrNull(catalog);
  if (value === null) return catalog.status === 'error' ? { kind: 'loaded', items: [] } : { kind: 'loading' };
  const bills = asyncValueOrNull(dueBills);
  if (bills === null) return dueBills.status === 'error' ? { kind: 'loaded', items: [] } : { kind: 'loading' };
  const byId = new Map<string, Biller>(value.billers.map((b) => [b.id, b]));
  return {
    kind: 'loaded',
    items: bills
      .filter((bill) => byId.get(bill.billerId)?.mode === 'presentment')
      .map((bill) => ({
        billerId: bill.billerId,
        account: bill.account,
        billerName: byId.get(bill.billerId)!.name,
        amountPaise: bill.amountPaise,
        dueInDays: daysUntilDue(bill.dueDate, now),
      })),
  };
};

export const useHomeScreenData = (): HomeScreenData => {
  const container = useContainer();
  const catalog = useStore(container.catalog, (s) => s.catalog);
  const saved = useStore(container.savedBillers, (s) => s.savedBillers);
  const dueBills = useStore(container.dueBills, (s) => s.dueBills);
  return {
    categories: projectHomeCategories(catalog),
    savedBillers: projectHomeSavedBillers(catalog, saved),
    reminders: projectHomeReminders(catalog, dueBills, saved, container.clock()),
  };
};

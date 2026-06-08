import { type Async } from '@/core/async/async';
import { daysUntilDue } from '@/core/format/formats';
import { type Biller, type BillerCatalog } from '@/features/billers/data/biller';
import type { FetchedBill } from '@/features/bills/data/fetchedBill';
import type { SavedBiller } from '@/features/saved_billers/data/savedBiller';
import { categoryIcon } from './categoryIcons';
import type { HomeCategoriesData, HomeRemindersData, HomeSavedBillersData } from './homeScreenData';

export function projectCategories(catalog: Async<BillerCatalog>): HomeCategoriesData {
  if (catalog.status === 'data') {
    return { kind: 'loaded', items: catalog.value.categories.map((c) => ({ id: c.id, name: c.name, icon: categoryIcon(c.id) })) };
  }
  if (catalog.status === 'error') return { kind: 'error', message: String(catalog.error) };
  return { kind: 'loading' };
}

export function projectSavedBillers(catalog: Async<BillerCatalog>, saved: SavedBiller[]): HomeSavedBillersData {
  if (saved.length === 0) return { kind: 'loaded', items: [] };
  if (catalog.status !== 'data') return catalog.status === 'error' ? { kind: 'loaded', items: [] } : { kind: 'loading' };
  const byId = new Map(catalog.value.billers.map((b) => [b.id, b] as const));
  return {
    kind: 'loaded',
    items: saved.map((s) => ({
      billerId: s.billerId,
      account: s.account,
      nickname: s.nickname,
      billerName: byId.get(s.billerId)?.name ?? s.billerId,
      openAmount: byId.get(s.billerId)?.mode === 'openAmount',
    })),
  };
}

export function projectReminders(catalog: Async<BillerCatalog>, dueBills: Async<FetchedBill[]>, saved: SavedBiller[], now: Date): HomeRemindersData {
  if (saved.length === 0) return { kind: 'loaded', items: [] };
  if (catalog.status !== 'data') return catalog.status === 'error' ? { kind: 'loaded', items: [] } : { kind: 'loading' };
  if (dueBills.status === 'error') return { kind: 'loaded', items: [] };
  if (dueBills.status === 'loading') return { kind: 'loading' };
  const byId = new Map(catalog.value.billers.map((b) => [b.id, b] as const));
  const items = dueBills.value
    .filter((bill) => byId.get(bill.billerId)?.mode === 'presentment')
    .map((bill) => ({
      billerId: bill.billerId,
      account: bill.account,
      billerName: (byId.get(bill.billerId) as Biller).name,
      amountPaise: bill.amountPaise,
      dueInDays: daysUntilDue(bill.dueDate, now),
    }));
  return { kind: 'loaded', items };
}

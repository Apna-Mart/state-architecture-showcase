import { projectReceipt } from '@/features/payments/ui/receiptProjection';
import { projectHistory } from '@/features/payments/ui/historyProjection';
import { projectReminders, projectSavedBillers, projectCategories } from '@/features/home/ui/homeProjection';
import type { Payments } from '@/features/payments/data/payment';
import type { SavedBillers } from '@/features/saved_billers/data/savedBiller';
import type { BillerCatalog } from '@/features/billers/data/biller';

const catalog: BillerCatalog = {
  categories: [{ id: 'electricity', name: 'Electricity' }],
  billers: [{ id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [] }],
};
const payment = { id: 'pay-1', billerId: 'electricity-metro', billerName: 'Metro Electricity', categoryId: 'electricity', account: 'K123', amountPaise: 45000, paidAtUtc: '2026-06-05T10:00:00.000Z' };
const payments = (status: 'processing' | 'success' | 'failed'): Payments => ({ items: [{ ...payment, status }], nextId: 2 });
const noSaved: SavedBillers = { items: [] };

test('receipt notFound when payment id is unknown', () => {
  expect(projectReceipt('ghost', { items: [], nextId: 1 }, noSaved).kind).toBe('notFound');
});
test('receipt processing/success/failed map by status', () => {
  expect(projectReceipt('pay-1', payments('processing'), noSaved).kind).toBe('processing');
  const success = projectReceipt('pay-1', payments('success'), noSaved);
  expect(success.kind).toBe('success');
  if (success.kind === 'success') expect(success.canSaveBiller).toBe(true);
  expect(projectReceipt('pay-1', payments('failed'), noSaved).kind).toBe('failed');
});
test('receipt success canSaveBiller false when already saved', () => {
  const saved: SavedBillers = { items: [{ billerId: 'electricity-metro', account: 'K123', nickname: 'Home' }] };
  const data = projectReceipt('pay-1', payments('success'), saved);
  if (data.kind === 'success') expect(data.canSaveBiller).toBe(false);
});

test('history empty then loaded newest-first', () => {
  expect(projectHistory({ items: [], nextId: 1 }).kind).toBe('empty');
  const loaded = projectHistory({ items: [{ ...payment, status: 'success' }, { ...payment, id: 'pay-2', status: 'failed' }], nextId: 3 });
  if (loaded.kind === 'loaded') expect(loaded.items[0]!.id).toBe('pay-2');
});

test('categories loaded from catalog', () => {
  const data = projectCategories({ status: 'data', value: catalog });
  if (data.kind === 'loaded') expect(data.items[0]!.id).toBe('electricity');
});
test('reminders empty when no saved billers', () => {
  expect(projectReminders({ status: 'data', value: catalog }, { status: 'loading' }, [], new Date(2026, 5, 5))).toEqual({ kind: 'loaded', items: [] });
});
test('saved billers empty list when none saved', () => {
  expect(projectSavedBillers({ status: 'data', value: catalog }, [])).toEqual({ kind: 'loaded', items: [] });
});

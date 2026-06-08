import { assertNever, type Async } from '@/core/async/async';
import { daysUntilDue } from '@/core/format/formats';
import { billerById, type Biller, type BillerCatalog } from '@/features/billers/data/biller';
import type { FetchedBill } from '../data/fetchedBill';
import type { BillReviewScreenData, ReviewParams } from './billReviewScreenData';

export function projectBillReview(
  params: ReviewParams,
  catalog: Async<BillerCatalog>,
  paying: boolean,
  bill: Async<FetchedBill>,
  now: Date,
): BillReviewScreenData {
  if (catalog.status === 'error') return { kind: 'error', message: String(catalog.error) };
  if (catalog.status === 'loading') return { kind: 'loading' };
  const biller = billerById(catalog.value, params.billerId);
  if (biller === undefined) return { kind: 'error', message: 'Biller not found' };

  if (biller.mode === 'openAmount') {
    if (params.amountPaise === null) return { kind: 'error', message: 'Amount missing' };
    return review(biller, params.account, params.amountPaise, null, null, paying);
  }
  switch (bill.status) {
    case 'data':
      return review(biller, params.account, bill.value.amountPaise, bill.value.customerName, daysUntilDue(bill.value.dueDate, now), paying);
    case 'error':
      return { kind: 'error', message: String(bill.error) };
    case 'loading':
      return { kind: 'loading' };
    default:
      return assertNever(bill);
  }
}

function review(biller: Biller, account: string, amountPaise: number, customerName: string | null, dueInDays: number | null, paying: boolean): BillReviewScreenData {
  return {
    kind: 'review',
    billerId: biller.id,
    categoryId: biller.categoryId,
    billerName: biller.name,
    account,
    customerName,
    dueInDays,
    amountPaise,
    paying,
    canPay: !paying,
  };
}

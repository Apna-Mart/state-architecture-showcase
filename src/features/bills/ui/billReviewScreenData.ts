import { useStore } from 'zustand';
import { type Async, asyncValueOrNull } from '../../../core/async/async';
import type { Clock } from '../../../core/clock/clock';
import { daysUntilDue } from '../../../core/format/formats';
import { billerById, type BillerCatalog } from '../../billers/data/billerCatalog';
import type { FetchedBill } from '../data/fetchedBill';
import { hasProcessing } from '../../payments/data/payment';
import { useContainer } from '../../../core/container/containerContext';

export interface ReviewParams { readonly billerId: string; readonly account: string; readonly amountPaise: number | null }
export type BillReviewScreenData =
  | { readonly kind: 'loading' }
  | { readonly kind: 'error'; readonly message: string }
  | {
      readonly kind: 'review';
      readonly billerId: string;
      readonly categoryId: string;
      readonly billerName: string;
      readonly account: string;
      readonly customerName: string | null;
      readonly dueInDays: number | null;
      readonly amountPaise: number;
      readonly paying: boolean;
      readonly canPay: boolean;
    };

export const projectBillReview = (
  catalog: Async<BillerCatalog>,
  bill: Async<FetchedBill> | undefined,
  params: ReviewParams,
  paying: boolean,
  clock: Clock,
): BillReviewScreenData => {
  if (catalog.status === 'error') return { kind: 'error', message: String(catalog.error) };
  const cat = asyncValueOrNull(catalog);
  if (cat === null) return { kind: 'loading' };
  const biller = billerById(cat, params.billerId);
  if (biller === null) return { kind: 'error', message: 'Biller not found' };

  const review = (amountPaise: number, customerName: string | null, dueInDays: number | null): BillReviewScreenData => ({
    kind: 'review',
    billerId: biller.id,
    categoryId: biller.categoryId,
    billerName: biller.name,
    account: params.account,
    customerName,
    dueInDays,
    amountPaise,
    paying,
    canPay: !paying,
  });

  if (biller.mode === 'openAmount') {
    if (params.amountPaise === null) return { kind: 'error', message: 'Amount missing' };
    return review(params.amountPaise, null, null);
  }
  if (bill === undefined || bill.status === 'loading') return { kind: 'loading' };
  if (bill.status === 'error') return { kind: 'error', message: String(bill.error) };
  return review(bill.value.amountPaise, bill.value.customerName, daysUntilDue(bill.value.dueDate, clock()));
};

export const useBillReviewScreenData = (params: ReviewParams): BillReviewScreenData => {
  const container = useContainer();
  const catalog = useStore(container.catalog, (s) => s.catalog);
  const paying = useStore(container.payments, (s) => hasProcessing(s.payments, params.billerId, params.account));
  const bill = useStore(container.bills, (s) => s.billFor(params.billerId, params.account));
  return projectBillReview(catalog, bill, params, paying, container.clock);
};

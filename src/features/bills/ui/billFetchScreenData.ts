import { type Async } from '../../../core/async/async';
import { billerById, type BillerCatalog } from '../../billers/data/billerCatalog';
import type { Biller } from '../../billers/data/biller';
import { amountPaise, valueOf, type BillFetchForm } from './billFetchForm';

export interface FetchFieldData { readonly key: string; readonly label: string; readonly hint: string }
export interface FetchInputsData { readonly fields: readonly FetchFieldData[]; readonly showAmount: boolean }
export type FetchSubmitAction = 'fetchBill' | 'continueToReview';
export interface FetchSubmitData { readonly action: FetchSubmitAction; readonly location: string | null }
export type BillFetchScreenData =
  | { readonly kind: 'loading' }
  | { readonly kind: 'error'; readonly message: string }
  | { readonly kind: 'form'; readonly billerName: string; readonly inputs: FetchInputsData; readonly submit: FetchSubmitData };

const reviewLocation = (biller: Biller, form: BillFetchForm, openAmount: boolean): string => {
  const account = encodeURIComponent(biller.inputParams.map((p) => valueOf(form, p.key).trim()).join('|'));
  const amount = openAmount ? `&amount=${amountPaise(form)}` : '';
  return `/biller/${biller.id}/review?account=${account}${amount}`;
};

export const projectBillFetch = (
  catalog: Async<BillerCatalog>,
  billerId: string,
  form: BillFetchForm,
): BillFetchScreenData => {
  if (catalog.status === 'loading') return { kind: 'loading' };
  if (catalog.status === 'error') return { kind: 'error', message: String(catalog.error) };
  const biller = billerById(catalog.value, billerId);
  if (biller === null) return { kind: 'error', message: 'Biller not found' };
  const openAmount = biller.mode === 'openAmount';
  const fieldsFilled = biller.inputParams.every((p) => valueOf(form, p.key).trim().length > 0);
  const amountValid = !openAmount || amountPaise(form) !== null;
  return {
    kind: 'form',
    billerName: biller.name,
    inputs: {
      fields: biller.inputParams.map((p) => ({ key: p.key, label: p.label, hint: p.hint })),
      showAmount: openAmount,
    },
    submit: {
      action: openAmount ? 'continueToReview' : 'fetchBill',
      location: fieldsFilled && amountValid ? reviewLocation(biller, form, openAmount) : null,
    },
  };
};

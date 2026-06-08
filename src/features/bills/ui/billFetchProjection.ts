import { assertNever, type Async } from '@/core/async/async';
import { billerById, type Biller, type BillerCatalog } from '@/features/billers/data/biller';
import { amountPaise, valueOf, type BillFetchForm } from './billFetchForm';
import type { BillFetchScreenData } from './billFetchScreenData';

export function projectBillFetch(billerId: string, catalog: Async<BillerCatalog>, form: BillFetchForm): BillFetchScreenData {
  switch (catalog.status) {
    case 'data': {
      const biller = billerById(catalog.value, billerId);
      if (biller === undefined) return { kind: 'error', message: 'Biller not found' };
      return formData(biller, form);
    }
    case 'error':
      return { kind: 'error', message: String(catalog.error) };
    case 'loading':
      return { kind: 'loading' };
    default:
      return assertNever(catalog);
  }
}

function formData(biller: Biller, form: BillFetchForm): BillFetchScreenData {
  const openAmount = biller.mode === 'openAmount';
  const fieldsFilled = biller.inputParams.every((p) => valueOf(form, p.key).trim() !== '');
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
}

function reviewLocation(biller: Biller, form: BillFetchForm, openAmount: boolean): string {
  const account = encodeURIComponent(biller.inputParams.map((p) => valueOf(form, p.key).trim()).join('|'));
  const amount = openAmount ? `&amount=${amountPaise(form)}` : '';
  return `/biller/${biller.id}/review?account=${account}${amount}`;
}

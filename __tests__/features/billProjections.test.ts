import { projectBillFetch } from '@/features/bills/ui/billFetchProjection';
import { projectBillReview } from '@/features/bills/ui/billReviewProjection';
import type { BillerCatalog } from '@/features/billers/data/biller';
import { emptyForm, settingValue } from '@/features/bills/ui/billFetchForm';

const catalog: BillerCatalog = {
  categories: [{ id: 'electricity', name: 'Electricity' }, { id: 'mobile-prepaid', name: 'Mobile Prepaid' }],
  billers: [
    { id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [{ key: 'account', label: 'Consumer Number', hint: 'Enter Consumer Number' }] },
    { id: 'mobile-prepaid-city', categoryId: 'mobile-prepaid', name: 'City Mobile Prepaid', mode: 'openAmount', inputParams: [{ key: 'account', label: 'Mobile Number', hint: 'Enter Mobile Number' }] },
  ],
};

test('presentment form action is fetchBill; location null until field filled', () => {
  const empty = projectBillFetch('electricity-metro', { status: 'data', value: catalog }, emptyForm());
  expect(empty.kind).toBe('form');
  if (empty.kind === 'form') {
    expect(empty.submit.action).toBe('fetchBill');
    expect(empty.submit.location).toBeNull();
  }
  const filled = projectBillFetch('electricity-metro', { status: 'data', value: catalog }, settingValue(emptyForm(), 'account', 'K123'));
  if (filled.kind === 'form') {
    expect(filled.submit.location).toBe('/biller/electricity-metro/review?account=K123');
  }
});

test('openAmount form action is continueToReview; needs both field and amount', () => {
  let form = settingValue(emptyForm(), 'account', '9999999999');
  const noAmount = projectBillFetch('mobile-prepaid-city', { status: 'data', value: catalog }, form);
  if (noAmount.kind === 'form') {
    expect(noAmount.submit.action).toBe('continueToReview');
    expect(noAmount.inputs.showAmount).toBe(true);
    expect(noAmount.submit.location).toBeNull();
  }
  form = { ...form, amountText: '250' };
  const withAmount = projectBillFetch('mobile-prepaid-city', { status: 'data', value: catalog }, form);
  if (withAmount.kind === 'form') {
    expect(withAmount.submit.location).toBe('/biller/mobile-prepaid-city/review?account=9999999999&amount=25000');
  }
});

test('review for openAmount with missing amount is error', () => {
  const data = projectBillReview(
    { billerId: 'mobile-prepaid-city', account: '9999999999', amountPaise: null },
    { status: 'data', value: catalog }, false, { status: 'loading' }, new Date(2026, 5, 5),
  );
  expect(data.kind).toBe('error');
});

test('review for presentment uses fetched bill amount and dueInDays', () => {
  const data = projectBillReview(
    { billerId: 'electricity-metro', account: 'K123', amountPaise: null },
    { status: 'data', value: catalog }, false,
    { status: 'data', value: { billerId: 'electricity-metro', account: 'K123', customerName: 'Ramesh Kumar', amountPaise: 45000, dueDate: new Date(2026, 5, 8), billNumber: 'BILL-X-1' } },
    new Date(2026, 5, 5),
  );
  expect(data.kind).toBe('review');
  if (data.kind === 'review') {
    expect(data.amountPaise).toBe(45000);
    expect(data.customerName).toBe('Ramesh Kumar');
    expect(data.dueInDays).toBe(3);
    expect(data.canPay).toBe(true);
  }
});

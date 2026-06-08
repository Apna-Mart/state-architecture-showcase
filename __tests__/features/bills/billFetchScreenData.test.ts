import { projectBillFetch } from '@/features/bills/ui/billFetchScreenData';
import { asyncData } from '@/core/async/async';
import { makeCatalog } from '@/features/billers/data/billerCatalog';
import { emptyForm, settingValue, settingAmount } from '@/features/bills/ui/billFetchForm';

const catalog = asyncData(makeCatalog([{ id: 'electricity', name: 'Electricity' }, { id: 'dth', name: 'DTH' }, { id: 'credit-card', name: 'Credit Card' }], [
  { id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [{ key: 'account', label: 'Consumer Number', hint: 'Enter Consumer Number' }] },
  { id: 'dth-metro', categoryId: 'dth', name: 'Metro DTH', mode: 'openAmount', inputParams: [{ key: 'account', label: 'Subscriber ID', hint: 'Enter Subscriber ID' }] },
  { id: 'credit-card-city', categoryId: 'credit-card', name: 'City Credit Card', mode: 'presentment', inputParams: [{ key: 'card', label: 'Card Number', hint: 'Last 4 digits' }, { key: 'mobile', label: 'Registered Mobile', hint: '10-digit mobile' }] },
]));

describe('projectBillFetch', () => {
  it('presentment enables fetchBill once the field is filled', () => {
    const empty = projectBillFetch(catalog, 'electricity-metro', emptyForm());
    expect(empty.kind === 'form' && empty.submit.action).toBe('fetchBill');
    expect(empty.kind === 'form' && empty.submit.location).toBeNull();
    const filled = projectBillFetch(catalog, 'electricity-metro', settingValue(emptyForm(), 'account', 'K123'));
    expect(filled.kind === 'form' && filled.submit.location).toBe('/biller/electricity-metro/review?account=K123');
  });
  it('openAmount requires a positive amount, action continueToReview', () => {
    const f1 = settingValue(emptyForm(), 'account', 'D77');
    const noAmount = projectBillFetch(catalog, 'dth-metro', f1);
    expect(noAmount.kind === 'form' && noAmount.inputs.showAmount).toBe(true);
    expect(noAmount.kind === 'form' && noAmount.submit.action).toBe('continueToReview');
    expect(noAmount.kind === 'form' && noAmount.submit.location).toBeNull();
    const withAmount = projectBillFetch(catalog, 'dth-metro', settingAmount(f1, '250'));
    expect(withAmount.kind === 'form' && withAmount.submit.location).toBe('/biller/dth-metro/review?account=D77&amount=25000');
  });
  it('credit card joins two values with a pipe', () => {
    let form = settingValue(emptyForm(), 'card', '4321');
    form = settingValue(form, 'mobile', '9876543210');
    const result = projectBillFetch(catalog, 'credit-card-city', form);
    expect(result.kind === 'form' && result.submit.location).toBe(`/biller/credit-card-city/review?account=${encodeURIComponent('4321|9876543210')}`);
  });
});

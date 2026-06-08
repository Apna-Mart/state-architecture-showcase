import { projectBillReview } from '@/features/bills/ui/billReviewScreenData';
import { asyncData, asyncError, asyncLoading } from '@/core/async/async';
import { makeCatalog } from '@/features/billers/data/billerCatalog';
import { fixedClock } from '@/core/clock/clock';

const catalog = makeCatalog([{ id: 'electricity', name: 'Electricity' }, { id: 'dth', name: 'DTH' }], [
  { id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [] },
  { id: 'dth-metro', categoryId: 'dth', name: 'Metro DTH', mode: 'openAmount', inputParams: [] },
]);
const clock = fixedClock(new Date(2026, 5, 5, 10));
const bill = { billerId: 'electricity-metro', account: 'K123', customerName: 'Ramesh Kumar', amountPaise: 45000, dueDate: new Date(2026, 5, 8), billNumber: 'BILL-X-1' };

describe('projectBillReview', () => {
  it('catalog loading is loading', () => {
    expect(projectBillReview(asyncLoading(), undefined, { billerId: 'electricity-metro', account: 'K123', amountPaise: null }, false, clock).kind).toBe('loading');
  });
  it('catalog error is error', () => {
    expect(projectBillReview(asyncError(new Error('x')), undefined, { billerId: 'electricity-metro', account: 'K123', amountPaise: null }, false, clock).kind).toBe('error');
  });
  it('openAmount uses the passed amount without a fetched bill', () => {
    const r = projectBillReview(asyncData(catalog), undefined, { billerId: 'dth-metro', account: 'D77', amountPaise: 25000 }, false, clock);
    expect(r.kind === 'review' && r.amountPaise).toBe(25000);
    expect(r.kind === 'review' && r.customerName).toBeNull();
    expect(r.kind === 'review' && r.dueInDays).toBeNull();
    expect(r.kind === 'review' && r.canPay).toBe(true);
  });
  it('openAmount with missing amount is an error', () => {
    expect(projectBillReview(asyncData(catalog), undefined, { billerId: 'dth-metro', account: 'D77', amountPaise: null }, false, clock).kind).toBe('error');
  });
  it('presentment review uses the fetched bill and computes dueInDays', () => {
    const r = projectBillReview(asyncData(catalog), asyncData(bill), { billerId: 'electricity-metro', account: 'K123', amountPaise: null }, false, clock);
    expect(r.kind === 'review' && r.customerName).toBe('Ramesh Kumar');
    expect(r.kind === 'review' && r.dueInDays).toBe(3);
    expect(r.kind === 'review' && r.amountPaise).toBe(45000);
  });
  it('paying disables pay', () => {
    const r = projectBillReview(asyncData(catalog), undefined, { billerId: 'dth-metro', account: 'D77', amountPaise: 25000 }, true, clock);
    expect(r.kind === 'review' && r.paying).toBe(true);
    expect(r.kind === 'review' && r.canPay).toBe(false);
  });
});

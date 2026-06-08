import { projectReceipt } from '@/features/payments/ui/receiptScreenData';
import { emptyPayments, adding, type Payment } from '@/features/payments/data/payment';
import { emptySavedBillers, addingSaved } from '@/features/saved_billers/data/savedBiller';

const mk = (status: Payment['status']): Payment => ({
  id: 'pay-1', billerId: 'electricity-metro', billerName: 'Metro Electricity',
  categoryId: 'electricity', account: 'K123', amountPaise: 45000,
  paidAtUtc: new Date('2026-06-05T10:00:00.000Z'), status,
});

describe('projectReceipt', () => {
  it('unknown id is notFound', () => {
    expect(projectReceipt(emptyPayments(), emptySavedBillers(), 'pay-99')).toEqual({ kind: 'notFound' });
  });
  it('processing projects amount and biller', () => {
    const r = projectReceipt(adding(emptyPayments(), mk('processing')), emptySavedBillers(), 'pay-1');
    expect(r.kind).toBe('processing');
  });
  it('success offers save when biller not saved, hides when saved', () => {
    const payments = adding(emptyPayments(), mk('success'));
    expect(projectReceipt(payments, emptySavedBillers(), 'pay-1').kind === 'success' &&
      (projectReceipt(payments, emptySavedBillers(), 'pay-1') as { canSaveBiller: boolean }).canSaveBiller).toBe(true);
    const saved = addingSaved(emptySavedBillers(), { billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
    const r = projectReceipt(payments, saved, 'pay-1');
    expect(r.kind === 'success' && r.canSaveBiller).toBe(false);
  });
  it('failed projects retry fields', () => {
    const r = projectReceipt(adding(emptyPayments(), mk('failed')), emptySavedBillers(), 'pay-1');
    expect(r.kind === 'failed' && r.billerId).toBe('electricity-metro');
    expect(r.kind === 'failed' && r.categoryId).toBe('electricity');
  });
});

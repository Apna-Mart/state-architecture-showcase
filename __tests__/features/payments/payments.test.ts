import { emptyPayments, byId, hasProcessing, adding, updatingStatus, type Payment } from '@/features/payments/data/payment';

const mk = (id: string, status: Payment['status']): Payment => ({
  id, billerId: 'b', billerName: 'B', categoryId: 'c', account: 'a',
  amountPaise: 100, paidAtUtc: new Date(0), status,
});

describe('Payments', () => {
  it('adding appends and bumps nextId', () => {
    const p = adding(emptyPayments(), mk('pay-1', 'processing'));
    expect(p.items.length).toBe(1);
    expect(p.nextId).toBe(2);
    expect(byId(p, 'pay-1')?.status).toBe('processing');
  });
  it('hasProcessing matches billerId + account + processing', () => {
    const p = adding(emptyPayments(), { ...mk('pay-1', 'processing'), billerId: 'x', account: 'y' });
    expect(hasProcessing(p, 'x', 'y')).toBe(true);
    expect(hasProcessing(p, 'x', 'z')).toBe(false);
  });
  it('updatingStatus replaces only the matching id immutably', () => {
    const p = adding(emptyPayments(), mk('pay-1', 'processing'));
    const next = updatingStatus(p, 'pay-1', 'success');
    expect(next.items[0]!.status).toBe('success');
    expect(p.items[0]!.status).toBe('processing');
  });
});

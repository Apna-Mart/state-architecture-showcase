import { projectHistory } from '@/features/payments/ui/historyScreenData';
import { emptyPayments, adding, type Payment } from '@/features/payments/data/payment';

const mk = (id: string, name: string, amount: number, status: Payment['status']): Payment => ({
  id, billerId: 'b', billerName: name, categoryId: 'c', account: 'a',
  amountPaise: amount, paidAtUtc: new Date(0), status,
});

describe('projectHistory', () => {
  it('empty before any payment', () => {
    expect(projectHistory(emptyPayments())).toEqual({ kind: 'empty' });
  });
  it('newest-first', () => {
    let p = adding(emptyPayments(), mk('pay-1', 'Metro Electricity', 10000, 'success'));
    p = adding(p, mk('pay-2', 'City Water', 20000, 'failed'));
    const r = projectHistory(p);
    expect(r.kind === 'loaded' && r.items[0]!.billerName).toBe('City Water');
    expect(r.kind === 'loaded' && r.items[0]!.status).toBe('failed');
    expect(r.kind === 'loaded' && r.items[1]!.status).toBe('success');
  });
});

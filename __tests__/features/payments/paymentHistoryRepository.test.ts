import { StoredPaymentHistoryRepository } from '@/features/payments/data/paymentHistoryRepository';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';
import { emptyPayments, adding, type Payment } from '@/features/payments/data/payment';

const mk = (status: Payment['status']): Payment => ({
  id: 'pay-1', billerId: 'electricity-metro', billerName: 'Metro Electricity',
  categoryId: 'electricity', account: 'K123', amountPaise: 45000,
  paidAtUtc: new Date('2026-06-05T10:00:00.000Z'), status,
});

describe('StoredPaymentHistoryRepository', () => {
  it('restore returns empty for an unknown user', () => {
    const repo = new StoredPaymentHistoryRepository(new InMemoryKeyValueStore());
    expect(repo.restore('user-x')).toEqual(emptyPayments());
  });
  it('round-trips with ISO dates and downgrades processing to failed on restore', async () => {
    const store = new InMemoryKeyValueStore();
    const repo = new StoredPaymentHistoryRepository(store);
    await repo.persist('user-9', adding(emptyPayments(), mk('processing')));
    const restored = repo.restore('user-9');
    expect(restored.items[0]!.status).toBe('failed');
    expect(restored.items[0]!.paidAtUtc.toISOString()).toBe('2026-06-05T10:00:00.000Z');
    expect(restored.nextId).toBe(2);
  });
});

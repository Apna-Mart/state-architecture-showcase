import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';
import { StoredPaymentHistoryRepository } from '@/features/payments/data/paymentHistoryRepository';

test('interrupted processing payment restores as failed, nextId preserved', () => {
  const store = new InMemoryKeyValueStore();
  store.write(
    'payments.user-9876543210',
    '{"nextId":2,"items":[{"id":"pay-1","billerId":"electricity-metro","billerName":"Metro Electricity","categoryId":"electricity","account":"K123","amountPaise":45000,"paidAtUtc":"2026-06-05T10:00:00.000Z","status":"processing"}]}',
  );
  const repo = new StoredPaymentHistoryRepository(store);
  const payments = repo.restore('user-9876543210');
  expect(payments.items[0]!.status).toBe('failed');
  expect(payments.nextId).toBe(2);
});

test('round-trips persist then restore for success records', () => {
  const store = new InMemoryKeyValueStore();
  const repo = new StoredPaymentHistoryRepository(store);
  const value = {
    nextId: 2,
    items: [{ id: 'pay-1', billerId: 'b', billerName: 'B', categoryId: 'c', account: 'a', amountPaise: 100, paidAtUtc: '2026-06-05T10:00:00.000Z', status: 'success' as const }],
  };
  repo.persist('user-1', value);
  expect(repo.restore('user-1').items[0]!.status).toBe('success');
});

test('restore of unknown user returns empty payments', () => {
  const repo = new StoredPaymentHistoryRepository(new InMemoryKeyValueStore());
  expect(repo.restore('nobody')).toEqual({ items: [], nextId: 1 });
});

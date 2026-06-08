import type { KeyValueStore } from '../../../core/storage/keyValueStore';
import { emptyPayments, type Payment, type Payments, type PaymentStatus } from './payment';

interface SerializedPayment {
  id: string; billerId: string; billerName: string; categoryId: string;
  account: string; amountPaise: number; paidAtUtc: string; status: PaymentStatus;
}

export interface PaymentHistoryRepository {
  restore(userId: string): Payments;
  persist(userId: string, value: Payments): Promise<void>;
}

const keyFor = (userId: string): string => `payments.${userId}`;

export class StoredPaymentHistoryRepository implements PaymentHistoryRepository {
  constructor(private readonly store: KeyValueStore) {}

  restore(userId: string): Payments {
    const raw = this.store.read(keyFor(userId));
    if (raw === null) return emptyPayments();
    const decoded = JSON.parse(raw) as { nextId: number; items: SerializedPayment[] };
    return {
      nextId: decoded.nextId,
      items: decoded.items.map((entry): Payment => ({
        id: entry.id,
        billerId: entry.billerId,
        billerName: entry.billerName,
        categoryId: entry.categoryId,
        account: entry.account,
        amountPaise: entry.amountPaise,
        paidAtUtc: new Date(entry.paidAtUtc),
        status: entry.status === 'processing' ? 'failed' : entry.status,
      })),
    };
  }

  persist(userId: string, value: Payments): Promise<void> {
    const payload = {
      nextId: value.nextId,
      items: value.items.map(
        (p): SerializedPayment => ({
          id: p.id,
          billerId: p.billerId,
          billerName: p.billerName,
          categoryId: p.categoryId,
          account: p.account,
          amountPaise: p.amountPaise,
          paidAtUtc: p.paidAtUtc.toISOString(),
          status: p.status,
        }),
      ),
    };
    return this.store.write(keyFor(userId), JSON.stringify(payload));
  }
}

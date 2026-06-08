import type { KeyValueStore } from '@/core/storage/keyValueStore';
import { emptyPayments, type Payment, type PaymentStatus, type Payments } from './payment';

const keyFor = (userId: string): string => `payments.${userId}`;

type RawPayment = Omit<Payment, 'status'> & { status: string };

export interface PaymentHistoryRepository {
  restore(userId: string): Payments;
  persist(userId: string, value: Payments): void;
}

export class StoredPaymentHistoryRepository implements PaymentHistoryRepository {
  constructor(private readonly store: KeyValueStore) {}

  restore(userId: string): Payments {
    const raw = this.store.read(keyFor(userId));
    if (raw === null) return emptyPayments();
    const decoded = JSON.parse(raw) as { nextId: number; items: RawPayment[] };
    return {
      nextId: decoded.nextId,
      items: decoded.items.map((entry) => ({
        ...entry,
        status: (entry.status === 'processing' ? 'failed' : entry.status) as PaymentStatus,
      })),
    };
  }

  persist(userId: string, value: Payments): void {
    this.store.write(keyFor(userId), JSON.stringify(value));
  }
}

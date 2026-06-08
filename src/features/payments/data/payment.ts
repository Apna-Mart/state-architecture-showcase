export type PaymentStatus = 'processing' | 'success' | 'failed';

export interface Payment {
  readonly id: string;
  readonly billerId: string;
  readonly billerName: string;
  readonly categoryId: string;
  readonly account: string;
  readonly amountPaise: number;
  readonly paidAtUtc: Date;
  readonly status: PaymentStatus;
}

export interface Payments {
  readonly items: readonly Payment[];
  readonly nextId: number;
}

export const emptyPayments = (): Payments => ({ items: [], nextId: 1 });

export const byId = (payments: Payments, id: string): Payment | null =>
  payments.items.find((p) => p.id === id) ?? null;

export const hasProcessing = (payments: Payments, billerId: string, account: string): boolean =>
  payments.items.some(
    (p) => p.billerId === billerId && p.account === account && p.status === 'processing',
  );

export const adding = (payments: Payments, payment: Payment): Payments => ({
  items: [...payments.items, payment],
  nextId: payments.nextId + 1,
});

export const updatingStatus = (payments: Payments, id: string, status: PaymentStatus): Payments => ({
  ...payments,
  items: payments.items.map((p) => (p.id === id ? { ...p, status } : p)),
});

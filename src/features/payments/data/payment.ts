export type PaymentStatus = 'processing' | 'success' | 'failed';

export type Payment = {
  id: string;
  billerId: string;
  billerName: string;
  categoryId: string;
  account: string;
  amountPaise: number;
  paidAtUtc: string;
  status: PaymentStatus;
};

export type Payments = { items: Payment[]; nextId: number };

export const emptyPayments = (): Payments => ({ items: [], nextId: 1 });

export const paymentById = (payments: Payments, id: string): Payment | undefined =>
  payments.items.find((p) => p.id === id);

export const hasProcessing = (payments: Payments, billerId: string, account: string): boolean =>
  payments.items.some(
    (p) => p.billerId === billerId && p.account === account && p.status === 'processing',
  );

export const addingPayment = (payments: Payments, payment: Payment): Payments => ({
  items: [...payments.items, payment],
  nextId: payments.nextId + 1,
});

export const updatingStatus = (payments: Payments, id: string, status: PaymentStatus): Payments => ({
  ...payments,
  items: payments.items.map((p) => (p.id === id ? { ...p, status } : p)),
});

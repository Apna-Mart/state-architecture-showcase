import { useStore } from 'zustand';
import type { PaymentStatus, Payments } from '../data/payment';
import { useContainer } from '../../../core/container/containerContext';
export interface PaymentListItemData {
  readonly id: string;
  readonly billerName: string;
  readonly account: string;
  readonly amountPaise: number;
  readonly paidAt: Date;
  readonly status: PaymentStatus;
}
export type HistoryScreenData =
  | { readonly kind: 'empty' }
  | { readonly kind: 'loaded'; readonly items: readonly PaymentListItemData[] };

export const projectHistory = (payments: Payments): HistoryScreenData => {
  if (payments.items.length === 0) return { kind: 'empty' };
  return {
    kind: 'loaded',
    items: [...payments.items].reverse().map((p) => ({
      id: p.id,
      billerName: p.billerName,
      account: p.account,
      amountPaise: p.amountPaise,
      paidAt: p.paidAtUtc,
      status: p.status,
    })),
  };
};

export const useHistoryScreenData = (): HistoryScreenData => {
  const container = useContainer();
  const payments = useStore(container.payments, (s) => s.payments);
  return projectHistory(payments);
};

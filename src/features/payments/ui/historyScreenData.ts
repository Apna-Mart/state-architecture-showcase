import type { PaymentStatus } from '../data/payment';

export type PaymentListItemData = {
  id: string;
  billerName: string;
  account: string;
  amountPaise: number;
  paidAt: string;
  status: PaymentStatus;
};
export type HistoryScreenData =
  | { kind: 'empty' }
  | { kind: 'loaded'; items: PaymentListItemData[] };

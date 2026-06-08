import { useStore } from 'zustand';
import { byId, type Payments } from '../data/payment';
import { contains, type SavedBillers } from '../../saved_billers/data/savedBiller';
import { useContainer } from '../../../core/container/containerContext';
import { assertNever } from '../../../core/async/async';

export type ReceiptScreenData =
  | { readonly kind: 'notFound' }
  | { readonly kind: 'processing'; readonly billerName: string; readonly amountPaise: number }
  | {
      readonly kind: 'success';
      readonly paymentId: string;
      readonly billerId: string;
      readonly billerName: string;
      readonly account: string;
      readonly amountPaise: number;
      readonly paidAt: Date;
      readonly canSaveBiller: boolean;
    }
  | {
      readonly kind: 'failed';
      readonly billerId: string;
      readonly billerName: string;
      readonly categoryId: string;
      readonly account: string;
      readonly amountPaise: number;
    };

export const projectReceipt = (payments: Payments, saved: SavedBillers, paymentId: string): ReceiptScreenData => {
  const payment = byId(payments, paymentId);
  if (payment === null) return { kind: 'notFound' };
  switch (payment.status) {
    case 'processing':
      return { kind: 'processing', billerName: payment.billerName, amountPaise: payment.amountPaise };
    case 'success':
      return {
        kind: 'success',
        paymentId: payment.id,
        billerId: payment.billerId,
        billerName: payment.billerName,
        account: payment.account,
        amountPaise: payment.amountPaise,
        paidAt: payment.paidAtUtc,
        canSaveBiller: !contains(saved, payment.billerId, payment.account),
      };
    case 'failed':
      return {
        kind: 'failed',
        billerId: payment.billerId,
        billerName: payment.billerName,
        categoryId: payment.categoryId,
        account: payment.account,
        amountPaise: payment.amountPaise,
      };
    default:
      return assertNever(payment.status);
  }
};

export const useReceiptScreenData = (paymentId: string): ReceiptScreenData => {
  const container = useContainer();
  const payments = useStore(container.payments, (s) => s.payments);
  const saved = useStore(container.savedBillers, (s) => s.savedBillers);
  return projectReceipt(payments, saved, paymentId);
};

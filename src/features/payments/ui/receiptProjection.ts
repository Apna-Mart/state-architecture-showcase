import { assertNever } from '@/core/async/async';
import { paymentById, type Payments } from '../data/payment';
import { savedContains, type SavedBillers } from '@/features/saved_billers/data/savedBiller';
import type { ReceiptScreenData } from './receiptScreenData';

export function projectReceipt(paymentId: string, payments: Payments, saved: SavedBillers): ReceiptScreenData {
  const payment = paymentById(payments, paymentId);
  if (payment === undefined) return { kind: 'notFound' };
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
        canSaveBiller: !savedContains(saved, payment.billerId, payment.account),
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
}

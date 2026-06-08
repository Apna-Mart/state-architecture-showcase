import { useStore } from 'zustand';
import { useContainer } from '@/core/containerContext';
import { projectReceipt } from './receiptProjection';
import type { ReceiptScreenData } from './receiptScreenData';

export function useReceiptScreenData(paymentId: string): ReceiptScreenData {
  const container = useContainer();
  const payments = useStore(container.payments, (s) => s.payments);
  const saved = useStore(container.savedBillers, (s) => s.savedBillers);
  return projectReceipt(paymentId, payments, saved);
}

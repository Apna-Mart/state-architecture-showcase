import { useStore } from 'zustand';
import { useContainer } from '@/core/containerContext';
import { projectHistory } from './historyProjection';
import type { HistoryScreenData } from './historyScreenData';

export function useHistoryScreenData(): HistoryScreenData {
  const container = useContainer();
  const payments = useStore(container.payments, (s) => s.payments);
  return projectHistory(payments);
}

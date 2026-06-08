import type { Payments } from '../data/payment';
import type { HistoryScreenData } from './historyScreenData';

export function projectHistory(payments: Payments): HistoryScreenData {
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
}

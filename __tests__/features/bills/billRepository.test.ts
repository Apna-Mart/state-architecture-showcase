import { FakeBillRepository } from '@/features/bills/data/billRepository';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { fixedClock } from '@/core/clock/clock';

const repo = () =>
  new FakeBillRepository(
    new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }),
    fixedClock(new Date(2026, 5, 5, 10)),
  );

describe('FakeBillRepository', () => {
  it('fetchBill is deterministic for the same billerId|account', async () => {
    const a = await repo().fetchBill('electricity-metro', 'K123');
    const b = await repo().fetchBill('electricity-metro', 'K123');
    expect(a.amountPaise).toBe(b.amountPaise);
    expect(a.customerName).toBe(b.customerName);
    expect(a.billNumber).toBe(b.billNumber);
  });
  it('amount is in 20000..470000 paise and billNumber has the BILL-{hex}-{seed} shape', async () => {
    const bill = await repo().fetchBill('electricity-metro', 'K123');
    expect(bill.amountPaise).toBeGreaterThanOrEqual(20000);
    expect(bill.amountPaise).toBeLessThanOrEqual(470000);
    expect(bill.billNumber).toMatch(/^BILL-[0-9A-F]+-\d+$/);
  });
  it('fetchDueBills maps one bill per saved biller', async () => {
    const bills = await repo().fetchDueBills([{ billerId: 'water-city', account: 'W9', nickname: 'x' }]);
    expect(bills.length).toBe(1);
    expect(bills[0]!.billerId).toBe('water-city');
  });
});

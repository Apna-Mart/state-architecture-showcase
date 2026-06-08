import { MockNetwork } from '@/core/mock/mockNetwork';
import { FakeBillRepository } from '@/features/bills/data/billRepository';

const fixed = () => new Date(2026, 5, 5);
const repo = () => new FakeBillRepository(new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }), fixed);

test('fetchBill is deterministic for same biller and account', async () => {
  const a = await repo().fetchBill('electricity-metro', 'K123');
  const b = await repo().fetchBill('electricity-metro', 'K123');
  expect(a.amountPaise).toBe(b.amountPaise);
  expect(a.customerName).toBe(b.customerName);
  expect(a.billNumber).toBe(b.billNumber);
});

test('amount is within the 20000..470000 paise band', async () => {
  const bill = await repo().fetchBill('electricity-metro', 'K123');
  expect(bill.amountPaise).toBeGreaterThanOrEqual(20000);
  expect(bill.amountPaise).toBeLessThanOrEqual(470000);
});

test('billNumber has the BILL-{hex}-{seed} shape', async () => {
  const bill = await repo().fetchBill('electricity-metro', 'K123');
  expect(bill.billNumber).toMatch(/^BILL-[0-9A-F]+-\d+$/);
});

test('fetchDueBills maps one bill per saved biller', async () => {
  const bills = await repo().fetchDueBills([{ billerId: 'water-city', account: 'W9', nickname: 'Home' }]);
  expect(bills).toHaveLength(1);
  expect(bills[0]!.billerId).toBe('water-city');
});

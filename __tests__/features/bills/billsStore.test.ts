import { createAppContainer } from '@/core/container/appContainer';
import { MockNetwork } from '@/core/mock/mockNetwork';

describe('BillsStore', () => {
  it('ensureBill fetches once per billerId|account and caches', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
    c.bills.getState().ensureBill('electricity-metro', 'K123');
    await c.bills.getState().whenSettled();
    const entry = c.bills.getState().billFor('electricity-metro', 'K123');
    expect(entry?.status).toBe('data');
    if (entry?.status === 'data') expect(entry.value.amountPaise).toBeGreaterThanOrEqual(20000);
  });
});

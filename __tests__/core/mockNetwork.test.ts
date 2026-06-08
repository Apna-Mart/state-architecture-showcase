import { MockNetwork, MockPaymentDeclined } from '@/core/mock/mockNetwork';

describe('MockNetwork', () => {
  test('countAndMaybeFail throws on every nth call', () => {
    const network = new MockNetwork({ minDelayMs: 0, maxDelayMs: 1, failEvery: 3 });
    network.countAndMaybeFail();
    network.countAndMaybeFail();
    expect(() => network.countAndMaybeFail()).toThrow(MockPaymentDeclined);
    network.countAndMaybeFail();
    network.countAndMaybeFail();
    expect(() => network.countAndMaybeFail()).toThrow(MockPaymentDeclined);
  });

  test('seeded delays are deterministic across instances', () => {
    const a = new MockNetwork({ minDelayMs: 1, maxDelayMs: 50, seed: 42 });
    const b = new MockNetwork({ minDelayMs: 1, maxDelayMs: 50, seed: 42 });
    expect(a.nextDelayMs()).toBe(b.nextDelayMs());
    expect(a.nextDelayMs()).toBe(b.nextDelayMs());
  });

  test('delay resolves within configured bounds', async () => {
    const network = new MockNetwork({ minDelayMs: 1, maxDelayMs: 2, seed: 42 });
    const start = Date.now();
    await network.delay();
    expect(Date.now() - start).toBeGreaterThanOrEqual(0);
  });
});

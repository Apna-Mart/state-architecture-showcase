import { MockNetwork, MockPaymentDeclined } from '@/core/mock/mockNetwork';

describe('MockNetwork', () => {
  it('countAndMaybeFail throws on every nth call', () => {
    const net = new MockNetwork({ minDelayMs: 0, maxDelayMs: 1, failEvery: 3 });
    net.countAndMaybeFail();
    net.countAndMaybeFail();
    expect(() => net.countAndMaybeFail()).toThrow(MockPaymentDeclined);
    net.countAndMaybeFail();
    net.countAndMaybeFail();
    expect(() => net.countAndMaybeFail()).toThrow(MockPaymentDeclined);
  });

  it('seeded delays are deterministic across instances', () => {
    const a = new MockNetwork({ minDelayMs: 1, maxDelayMs: 50 });
    const b = new MockNetwork({ minDelayMs: 1, maxDelayMs: 50 });
    expect(a.nextDelayMs()).toBe(b.nextDelayMs());
    expect(a.nextDelayMs()).toBe(b.nextDelayMs());
  });

  it('delay resolves within bounds', async () => {
    const net = new MockNetwork({ minDelayMs: 1, maxDelayMs: 2 });
    await expect(net.delay()).resolves.toBeUndefined();
  });
});

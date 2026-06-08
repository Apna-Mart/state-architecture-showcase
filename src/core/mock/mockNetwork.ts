export class MockPaymentDeclined extends Error {
  constructor() {
    super('MockPaymentDeclined');
    this.name = 'MockPaymentDeclined';
  }
}

function mulberry32(seed: number): () => number {
  let a = seed >>> 0;
  return () => {
    a |= 0;
    a = (a + 0x6d2b79f5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

type MockNetworkOptions = {
  minDelayMs?: number;
  maxDelayMs?: number;
  failEvery?: number;
  seed?: number;
};

export class MockNetwork {
  private readonly minDelayMs: number;
  private readonly maxDelayMs: number;
  private readonly failEvery: number;
  private readonly random: () => number;
  private failCounter = 0;

  constructor(options: MockNetworkOptions = {}) {
    this.minDelayMs = options.minDelayMs ?? 300;
    this.maxDelayMs = options.maxDelayMs ?? 800;
    this.failEvery = options.failEvery ?? 10;
    this.random = mulberry32(options.seed ?? 42);
  }

  nextDelayMs(): number {
    const span = Math.max(1, this.maxDelayMs - this.minDelayMs);
    return this.minDelayMs + Math.floor(this.random() * span);
  }

  delay(times = 1): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, this.nextDelayMs() * times));
  }

  countAndMaybeFail(): void {
    this.failCounter += 1;
    if (this.failCounter % this.failEvery === 0) throw new MockPaymentDeclined();
  }
}

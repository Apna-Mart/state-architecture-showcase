import { SeededRandom } from './seededRandom';

export class MockPaymentDeclined extends Error {
  constructor() {
    super('MockPaymentDeclined');
    this.name = 'MockPaymentDeclined';
  }
}

export interface MockNetworkOptions {
  minDelayMs?: number;
  maxDelayMs?: number;
  failEvery?: number;
  seed?: number;
}

export class MockNetwork {
  private readonly minDelayMs: number;
  private readonly maxDelayMs: number;
  private readonly failEvery: number;
  private readonly rng: SeededRandom;
  private failCounter = 0;

  constructor(options: MockNetworkOptions = {}) {
    this.minDelayMs = options.minDelayMs ?? 300;
    this.maxDelayMs = options.maxDelayMs ?? 800;
    this.failEvery = options.failEvery ?? 10;
    this.rng = new SeededRandom(options.seed ?? 42);
  }

  nextDelayMs(): number {
    return this.minDelayMs + this.rng.nextInt(Math.max(1, this.maxDelayMs - this.minDelayMs));
  }

  delay(times = 1): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, this.nextDelayMs() * times));
  }

  countAndMaybeFail(): void {
    this.failCounter += 1;
    if (this.failCounter % this.failEvery === 0) throw new MockPaymentDeclined();
  }
}

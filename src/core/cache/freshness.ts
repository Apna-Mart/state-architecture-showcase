import type { Clock } from '../clock/clock';

export class Freshness {
  private fetchedAt: number | null = null;

  constructor(private readonly clock: Clock, private readonly maxAgeMs: number) {}

  markFetched(): void {
    this.fetchedAt = this.clock().getTime();
  }

  isStale(): boolean {
    if (this.fetchedAt === null) return true;
    return this.clock().getTime() - this.fetchedAt >= this.maxAgeMs;
  }
}

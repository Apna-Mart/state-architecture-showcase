import { Freshness } from '@/core/cache/freshness';
import { fixedClock } from '@/core/clock/clock';

describe('Freshness', () => {
  it('is stale only after maxAge elapses', () => {
    let now = new Date('2026-06-05T10:00:00.000Z');
    const fresh = new Freshness(() => now, 30 * 60_000);
    fresh.markFetched();
    now = new Date(now.getTime() + 10 * 60_000);
    expect(fresh.isStale()).toBe(false);
    now = new Date(now.getTime() + 21 * 60_000);
    expect(fresh.isStale()).toBe(true);
  });

  it('is stale before the first fetch', () => {
    const fresh = new Freshness(fixedClock(new Date()), 1000);
    expect(fresh.isStale()).toBe(true);
  });
});

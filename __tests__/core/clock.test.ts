import { systemClock, fixedClock } from '@/core/clock/clock';

describe('Clock', () => {
  it('fixedClock returns the same instant on every call', () => {
    const when = new Date('2026-06-05T10:00:00.000Z');
    const clock = fixedClock(when);
    expect(clock().getTime()).toBe(when.getTime());
    expect(clock().getTime()).toBe(when.getTime());
  });

  it('systemClock returns a Date', () => {
    expect(systemClock()).toBeInstanceOf(Date);
  });
});

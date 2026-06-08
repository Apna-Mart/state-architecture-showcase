import { formatPaise, formatDate, daysUntilDue } from '@/core/format/formats';

describe('formats', () => {
  it('formatPaise renders rupees in en-IN grouping', () => {
    expect(formatPaise(123456789, 'en')).toContain('₹');
    expect(formatPaise(123456789, 'en')).toContain('12,34,567.89');
  });

  it('formatPaise renders arabic-indic digits for ar with the rupee symbol', () => {
    const arabic = formatPaise(123456789, 'ar');
    expect(arabic).toContain('₹');
    expect(arabic).toContain('١');
  });

  it('formatDate renders day month year', () => {
    expect(formatDate(new Date(2026, 5, 5), 'en')).toBe('5 Jun 2026');
    expect(formatDate(new Date(2026, 5, 5), 'ar')).toContain('٢٠٢٦');
  });

  it('daysUntilDue counts calendar days ignoring time of day', () => {
    const now = new Date(2026, 5, 5, 14, 30);
    expect(daysUntilDue(new Date(2026, 5, 3), now)).toBe(-2);
    expect(daysUntilDue(new Date(2026, 5, 4), now)).toBe(-1);
    expect(daysUntilDue(new Date(2026, 5, 5), now)).toBe(0);
    expect(daysUntilDue(new Date(2026, 5, 6), now)).toBe(1);
    expect(daysUntilDue(new Date(2026, 5, 8), now)).toBe(3);
  });
});

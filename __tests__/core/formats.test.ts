import { formatPaise, formatDate, daysUntilDue } from '@/core/format/formats';

describe('formats', () => {
  test('formatPaise renders rupees with Indian grouping for en/hi', () => {
    expect(formatPaise(123456789, 'en')).toBe('₹12,34,567.89');
    expect(formatPaise(123456789, 'hi')).toBe('₹12,34,567.89');
  });

  test('formatPaise renders Arabic digits and the rupee symbol for ar', () => {
    const arabic = formatPaise(123456789, 'ar');
    expect(arabic).toContain('₹');
    expect(arabic).toContain('١');
  });

  test('formatDate renders day month year per locale', () => {
    expect(formatDate(new Date(2026, 5, 5), 'en')).toBe('5 Jun 2026');
    expect(formatDate(new Date(2026, 5, 5), 'ar')).toContain('٢٠٢٦');
  });

  test('daysUntilDue counts calendar days ignoring time of day', () => {
    const now = new Date(2026, 5, 5, 14, 30);
    expect(daysUntilDue(new Date(2026, 5, 3), now)).toBe(-2);
    expect(daysUntilDue(new Date(2026, 5, 4), now)).toBe(-1);
    expect(daysUntilDue(new Date(2026, 5, 5), now)).toBe(0);
    expect(daysUntilDue(new Date(2026, 5, 6), now)).toBe(1);
    expect(daysUntilDue(new Date(2026, 5, 8), now)).toBe(3);
  });
});

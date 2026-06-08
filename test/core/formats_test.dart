import 'package:billpayments/core/format/formats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(initializeDateFormatting);

  test('formatPaise renders rupees per locale', () {
    expect(formatPaise(123456789, 'en'), '₹12,34,567.89');
    expect(formatPaise(123456789, 'hi'), '₹12,34,567.89');
    final arabic = formatPaise(123456789, 'ar');
    expect(arabic, contains('₹'));
    expect(arabic, contains('١'));
  });

  test('formatDate renders day month year per locale', () {
    expect(formatDate(DateTime(2026, 6, 5), 'en'), '5 Jun 2026');
    expect(formatDate(DateTime(2026, 6, 5), 'ar'), contains('٢٠٢٦'));
  });

  test('daysUntilDue counts calendar days ignoring time of day', () {
    final now = DateTime(2026, 6, 5, 14, 30);
    expect(daysUntilDue(DateTime(2026, 6, 3), now), -2);
    expect(daysUntilDue(DateTime(2026, 6, 4), now), -1);
    expect(daysUntilDue(DateTime(2026, 6, 5), now), 0);
    expect(daysUntilDue(DateTime(2026, 6, 6), now), 1);
    expect(daysUntilDue(DateTime(2026, 6, 8), now), 3);
  });
}

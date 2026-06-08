import 'package:intl/intl.dart';

import 'locale_config.dart';

LocaleConfig _configFor(String locale) =>
    localeConfigs[locale] ?? localeConfigs['en']!;

String formatPaise(int paise, String locale) {
  final config = _configFor(locale);
  return NumberFormat.currency(
          locale: config.numberLocale,
          symbol: config.currencySymbol,
          decimalDigits: 2)
      .format(paise / 100);
}

String formatDate(DateTime date, String locale) =>
    DateFormat('d MMM yyyy', _configFor(locale).dateLocale).format(date);

int daysUntilDue(DateTime due, DateTime now) =>
    DateTime(due.year, due.month, due.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

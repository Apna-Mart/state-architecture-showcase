class LocaleConfig {
  const LocaleConfig({
    required this.numberLocale,
    required this.dateLocale,
    required this.currencySymbol,
  });

  final String numberLocale;
  final String dateLocale;
  final String currencySymbol;
}

const localeConfigs = <String, LocaleConfig>{
  'en': LocaleConfig(numberLocale: 'en_IN', dateLocale: 'en', currencySymbol: '₹'),
  'hi': LocaleConfig(numberLocale: 'hi', dateLocale: 'hi', currencySymbol: '₹'),
  'ar': LocaleConfig(
      numberLocale: 'ar_EG', dateLocale: 'ar_EG', currencySymbol: '₹'),
};

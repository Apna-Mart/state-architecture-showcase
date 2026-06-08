import 'dart:ui';

import 'package:billpayments/core/format/locale_config.dart';
import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:billpayments/l10n/app_localizations.dart';
import 'package:billpayments/l10n/l10n_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer containerWithStoredLanguage(String? language) {
  final store = InMemoryKeyValueStore();
  if (language != null) store.write('settings.locale', language);
  final container = ProviderContainer(
    overrides: [keyValueStoreProvider.overrideWithValue(store)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('every supported locale resolves through lookupAppLocalizations', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final localizations = lookupAppLocalizations(locale);
      expect(localizations.localeName, locale.languageCode);
    }
  });

  test('localeConfigs covers exactly the generated supported locales', () {
    final generated =
        AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();
    expect(localeConfigs.keys.toSet(), generated);
  });

  test('l10nProvider only emits supported locales', () {
    for (final stored in [null, 'en', 'hi', 'ar', 'fr', 'zh']) {
      final container = containerWithStoredLanguage(stored);
      final locale = container.read(l10nProvider).locale;
      expect(AppLocalizations.supportedLocales, contains(locale));
    }
  });

  test('l10nProvider strings match its locale', () {
    for (final stored in ['en', 'hi', 'ar']) {
      final container = containerWithStoredLanguage(stored);
      final l10n = container.read(l10nProvider);
      expect(l10n.strings.localeName, l10n.locale.languageCode);
    }
  });

  test('system locale change updates l10n when no override is set', () {
    final container = containerWithStoredLanguage(null);
    container.listen(l10nProvider, (_, _) {});
    container.read(platformLocaleProvider.notifier).didChangeLocales(
        const [Locale('hi'), Locale('en')]);
    expect(container.read(l10nProvider).locale, const Locale('hi'));
    expect(container.read(l10nProvider).strings.localeName, 'hi');
  });

  test('locale override wins over system locale changes', () {
    final container = containerWithStoredLanguage('ar');
    container.listen(l10nProvider, (_, _) {});
    container.read(platformLocaleProvider.notifier).didChangeLocales(
        const [Locale('hi')]);
    expect(container.read(l10nProvider).locale, const Locale('ar'));
  });
}

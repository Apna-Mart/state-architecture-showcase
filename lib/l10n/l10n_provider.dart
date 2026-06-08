import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/format/locale_config.dart';
import '../features/settings/data/settings_provider.dart';
import 'app_localizations.dart';

final platformLocaleProvider =
    NotifierProvider<PlatformLocaleNotifier, Locale>(PlatformLocaleNotifier.new);

class PlatformLocaleNotifier extends Notifier<Locale>
    with WidgetsBindingObserver {
  @override
  Locale build() {
    final binding = WidgetsBinding.instance;
    binding.addObserver(this);
    ref.onDispose(() => binding.removeObserver(this));
    return binding.platformDispatcher.locale;
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    final first = locales?.firstOrNull;
    if (first != null) state = first;
  }
}

final l10nProvider = Provider<({Locale locale, AppLocalizations strings})>(
  (ref) {
    final override =
        ref.watch(settingsProvider.select((s) => s.localeOverride));
    final platform = ref.watch(platformLocaleProvider);
    final locale = override ??
        (localeConfigs.containsKey(platform.languageCode)
            ? Locale(platform.languageCode)
            : const Locale('en'));
    return (locale: locale, strings: lookupAppLocalizations(locale));
  },
);

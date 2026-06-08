import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_localizations.dart';
import 'l10n_provider.dart';

extension L10nRef on WidgetRef {
  AppLocalizations get l10n => watch(l10nProvider).strings;
  String get languageCode => watch(l10nProvider).locale.languageCode;
}

String dueLabel(AppLocalizations l10n, int days) {
  if (days < 0) return l10n.overdueByDays(-days);
  if (days == 0) return l10n.dueToday;
  return l10n.dueInDays(days);
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/event/ui_event.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/billers/data/biller_catalog_provider.dart';
import 'features/bills/data/due_bills_provider.dart';
import 'features/settings/data/settings_provider.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n_provider.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: _refreshStale);
  }

  void _refreshStale() {
    ref.read(billerCatalogProvider.notifier).refreshIfStale();
    ref.read(dueBillsProvider.notifier).refreshIfStale();
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(uiEventProvider, (_, events) {
      for (final event in events) {
        _handle(event);
        ref.read(uiEventProvider.notifier).consume(event);
      }
    });
    final settings = ref.watch(settingsProvider);
    return MaterialApp.router(
      onGenerateTitle: (_) => ref.read(l10nProvider).strings.appTitle,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      locale: ref.watch(l10nProvider).locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }

  void _handle(UiEvent event) {
    if (event case PaymentStarted(:final paymentId)) {
      ref.read(appRouterProvider).go('/payment/$paymentId');
      return;
    }
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;
    final l10n = ref.read(l10nProvider).strings;
    switch (event) {
      case PaymentFailed():
        messenger.showSnackBar(
            SnackBar(content: Text(l10n.paymentFailedRetry)));
      case OtpRejected():
        messenger
            .showSnackBar(SnackBar(content: Text(l10n.invalidOtpMessage)));
      case AuthFailed():
        messenger
            .showSnackBar(SnackBar(content: Text(l10n.somethingWentWrong)));
      case StorageFailed():
        messenger.showSnackBar(
            SnackBar(content: Text(l10n.storageFailedMessage)));
      case PaymentStarted():
        return;
    }
  }
}

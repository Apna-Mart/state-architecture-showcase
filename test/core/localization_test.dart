import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/ui/login_screen.dart';
import 'package:billpayments/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget localizedHost(Widget child, {Locale? locale}) => ProviderScope(
      overrides: [
        mockNetworkProvider
            .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );

void main() {
  testWidgets('arabic locale renders right-to-left', (tester) async {
    await tester.pumpWidget(
        localizedHost(const LoginScreen(), locale: const Locale('ar')));
    expect(Directionality.of(tester.element(find.byType(LoginScreen))),
        TextDirection.rtl);
  });

  testWidgets('default locale renders left-to-right', (tester) async {
    await tester.pumpWidget(localizedHost(const LoginScreen()));
    expect(Directionality.of(tester.element(find.byType(LoginScreen))),
        TextDirection.ltr);
  });
}

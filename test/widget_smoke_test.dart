import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/ui/login_screen.dart';
import 'package:billpayments/features/home/ui/home_screen.dart';
import 'package:billpayments/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget host(Widget child) => ProviderScope(
      overrides: [
        mockNetworkProvider
            .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );

void main() {
  testWidgets('login renders phone entry and enables send on valid phone',
      (tester) async {
    await tester.pumpWidget(host(const LoginScreen()));
    expect(find.text('Send OTP'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull);
    await tester.enterText(find.byType(TextField), '9876543210');
    await tester.pump();
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNotNull);
  });

  testWidgets('home renders loading then category grid', (tester) async {
    await tester.pumpWidget(host(const HomeScreen()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Pay a bill'), findsOneWidget);
    expect(find.text('Electricity'), findsOneWidget);
    expect(find.text('Water'), findsOneWidget);
  });
}

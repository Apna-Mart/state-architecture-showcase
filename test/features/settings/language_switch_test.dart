import 'package:billpayments/app.dart';
import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('switching language in settings relocalizes the app instantly',
      (tester) async {
    final store = InMemoryKeyValueStore();
    await store.write('session.userId', 'user-9876543210');
    await store.write('session.phone', '9876543210');
    await tester.pumpWidget(ProviderScope(
      overrides: [
        keyValueStoreProvider.overrideWithValue(store),
        mockNetworkProvider
            .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
      ],
      child: const App(),
    ));
    await tester.pumpAndSettle();
    expect(find.text('ApnaMart'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await tester.tap(find.text('हिन्दी'));
    await tester.pumpAndSettle();
    expect(find.text('सेटिंग्स'), findsOneWidget);
    expect(store.read('settings.locale'), 'hi');
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('बिजली'), findsOneWidget);
    expect(find.text('Electricity'), findsNothing);
  });
}

import 'package:billpayments/app.dart';
import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:billpayments/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<KeyValueStore> seededStore(Map<String, String> values) async {
  final store = InMemoryKeyValueStore();
  for (final entry in values.entries) {
    await store.write(entry.key, entry.value);
  }
  return store;
}

Widget appWith(KeyValueStore store) => ProviderScope(
      overrides: [
        keyValueStoreProvider.overrideWithValue(store),
        mockNetworkProvider
            .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
      ],
      child: const App(),
    );

void main() {
  testWidgets('stored dark theme mode renders dark brightness',
      (tester) async {
    final store = await seededStore({
      'session.userId': 'user-9876543210',
      'session.phone': '9876543210',
      'settings.themeMode': 'dark',
    });
    await tester.pumpWidget(appWith(store));
    await tester.pumpAndSettle();
    expect(
        Theme.of(tester.element(find.byType(HomeScreen))).brightness,
        Brightness.dark);
  });

  testWidgets('stored arabic locale renders app right-to-left',
      (tester) async {
    final store = await seededStore({
      'session.userId': 'user-9876543210',
      'session.phone': '9876543210',
      'settings.locale': 'ar',
    });
    await tester.pumpWidget(appWith(store));
    await tester.pumpAndSettle();
    expect(Directionality.of(tester.element(find.byType(HomeScreen))),
        TextDirection.rtl);
  });
}

import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:billpayments/features/settings/data/app_settings.dart';
import 'package:billpayments/features/settings/data/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer containerWith(KeyValueStore store) {
  final container = ProviderContainer(overrides: [
    keyValueStoreProvider.overrideWithValue(store),
  ]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('defaults to system theme and no locale override on empty store', () {
    final container = containerWith(InMemoryKeyValueStore());
    expect(
      container.read(settingsProvider),
      const AppSettings(localeOverride: null, themeMode: ThemeMode.system),
    );
  });

  test('hydrates stored locale and theme mode', () async {
    final store = InMemoryKeyValueStore();
    await store.write('settings.locale', 'hi');
    await store.write('settings.themeMode', 'dark');
    final container = containerWith(store);
    expect(
      container.read(settingsProvider),
      const AppSettings(
          localeOverride: Locale('hi'), themeMode: ThemeMode.dark),
    );
  });

  test('corrupt stored values fall back to defaults', () async {
    final store = InMemoryKeyValueStore();
    await store.write('settings.locale', 'xx');
    await store.write('settings.themeMode', 'neon');
    final container = containerWith(store);
    expect(
      container.read(settingsProvider),
      const AppSettings(localeOverride: null, themeMode: ThemeMode.system),
    );
  });

  test('setLocale updates state and persists language code', () async {
    final store = InMemoryKeyValueStore();
    final container = containerWith(store);
    await container
        .read(settingsProvider.notifier)
        .setLocale(const Locale('ar'));
    expect(container.read(settingsProvider).localeOverride,
        const Locale('ar'));
    expect(store.read('settings.locale'), 'ar');
  });

  test('setLocale null clears override and removes stored key', () async {
    final store = InMemoryKeyValueStore();
    await store.write('settings.locale', 'hi');
    final container = containerWith(store);
    await container.read(settingsProvider.notifier).setLocale(null);
    expect(container.read(settingsProvider).localeOverride, isNull);
    expect(store.read('settings.locale'), isNull);
  });

  test('setThemeMode updates state and persists name', () async {
    final store = InMemoryKeyValueStore();
    final container = containerWith(store);
    await container
        .read(settingsProvider.notifier)
        .setThemeMode(ThemeMode.dark);
    expect(container.read(settingsProvider).themeMode, ThemeMode.dark);
    expect(store.read('settings.themeMode'), 'dark');
  });
}

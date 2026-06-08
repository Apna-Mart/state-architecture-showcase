import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/format/locale_config.dart';
import '../../../core/storage/key_value_store.dart';
import 'app_settings.dart';

abstract interface class SettingsRepository {
  AppSettings restore();
  Future<void> saveLocale(Locale? locale);
  Future<void> saveThemeMode(ThemeMode mode);
}

class StoredSettingsRepository implements SettingsRepository {
  StoredSettingsRepository(this._store);

  final KeyValueStore _store;

  static const _localeKey = 'settings.locale';
  static const _themeModeKey = 'settings.themeMode';

  @override
  AppSettings restore() {
    final language = _store.read(_localeKey);
    final themeName = _store.read(_themeModeKey);
    return AppSettings(
      localeOverride:
          language != null && localeConfigs.containsKey(language)
              ? Locale(language)
              : null,
      themeMode: ThemeMode.values.asNameMap()[themeName] ?? ThemeMode.system,
    );
  }

  @override
  Future<void> saveLocale(Locale? locale) => locale == null
      ? _store.remove(_localeKey)
      : _store.write(_localeKey, locale.languageCode);

  @override
  Future<void> saveThemeMode(ThemeMode mode) =>
      _store.write(_themeModeKey, mode.name);
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => StoredSettingsRepository(ref.watch(keyValueStoreProvider)),
);

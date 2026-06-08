import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/storage/key_value_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    // Display-mode hint must never block launch (noActivity/noAPI on API <23)
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } on PlatformException {
      // System keeps default refresh rate
    }
  }
  await initializeDateFormatting('ar_EG');
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      keyValueStoreProvider.overrideWithValue(PrefsKeyValueStore(prefs)),
    ],
    child: const App(),
  ));
}

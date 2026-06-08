import 'package:billpayments/core/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('light theme uses ApnaMart brand anchors', () {
    final scheme = AppTheme.light.colorScheme;
    expect(scheme.brightness, Brightness.light);
    expect(scheme.primary, const Color(0xFF11448A));
    expect(scheme.onPrimary, Colors.white);
    expect(scheme.secondary, const Color(0xFFFACC15));
    expect(scheme.onSecondary, const Color(0xFF11448A));
    expect(scheme.tertiary, const Color(0xFFFFCA49));
    expect(scheme.onTertiary, const Color(0xFF11448A));
  });

  test('dark theme lightens blue and keeps yellow accent', () {
    final scheme = AppTheme.dark.colorScheme;
    expect(scheme.brightness, Brightness.dark);
    expect(scheme.primary, const Color(0xFF3161AD));
    expect(scheme.secondary, const Color(0xFFFACC15));
  });

  test('both themes apply Rubik typography', () {
    expect(AppTheme.light.textTheme.bodyMedium?.fontFamily, startsWith('Rubik'));
    expect(AppTheme.dark.textTheme.bodyMedium?.fontFamily, startsWith('Rubik'));
  });

  test('light app bar is brand blue with white foreground', () {
    final appBar = AppTheme.light.appBarTheme;
    expect(appBar.backgroundColor, const Color(0xFF11448A));
    expect(appBar.foregroundColor, Colors.white);
  });

  test('headings are bold like the brand site', () {
    expect(AppTheme.light.textTheme.headlineMedium?.fontWeight, FontWeight.w700);
    expect(AppTheme.light.textTheme.titleLarge?.fontWeight, FontWeight.w700);
  });

  test('bundled Rubik weights are distinct font files', () async {
    final regularData = await rootBundle.load('assets/fonts/Rubik-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/Rubik-Bold.ttf');
    final regular = regularData.buffer.asUint8List();
    final bold = boldData.buffer.asUint8List();
    expect(regular.length == bold.length && listEquals(regular, bold), isFalse);
  });
}

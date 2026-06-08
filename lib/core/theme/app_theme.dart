import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const brandBlue = Color(0xFF11448A);
  static const brandBlueLight = Color(0xFF3161AD);
  static const brandYellow = Color(0xFFFACC15);
  static const brandYellowSoft = Color(0xFFFFCA49);

  static ThemeData get light => _build(_lightScheme);

  static ThemeData get dark => _build(_darkScheme);

  static ColorScheme get _lightScheme =>
      ColorScheme.fromSeed(seedColor: brandBlue).copyWith(
        primary: brandBlue,
        onPrimary: Colors.white,
        secondary: brandYellow,
        onSecondary: brandBlue,
        tertiary: brandYellowSoft,
        onTertiary: brandBlue,
      );

  static ColorScheme get _darkScheme => ColorScheme.fromSeed(
        seedColor: brandBlue,
        brightness: Brightness.dark,
      ).copyWith(
        primary: brandBlueLight,
        onPrimary: Colors.white,
        secondary: brandYellow,
        onSecondary: brandBlue,
        tertiary: brandYellowSoft,
        onTertiary: brandBlue,
      );

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(colorScheme: scheme);
    return base.copyWith(
      textTheme: _rubikTextTheme(base.textTheme),
      appBarTheme: _appBarTheme(scheme),
      filledButtonTheme: FilledButtonThemeData(style: _buttonStyle),
      elevatedButtonTheme: ElevatedButtonThemeData(style: _buttonStyle),
      cardTheme: base.cardTheme.copyWith(shape: _roundedBorder(12)),
      chipTheme: base.chipTheme.copyWith(shape: _roundedBorder(8)),
    );
  }

  static TextTheme _rubikTextTheme(TextTheme base) {
    final rubik = GoogleFonts.rubikTextTheme(base);
    return rubik.copyWith(
      headlineLarge: rubik.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
      headlineMedium:
          rubik.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
      headlineSmall: rubik.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      titleLarge: rubik.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    );
  }

  static AppBarTheme _appBarTheme(ColorScheme scheme) {
    if (scheme.brightness == Brightness.dark) return const AppBarTheme();
    return AppBarTheme(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
    );
  }

  static ButtonStyle get _buttonStyle =>
      ButtonStyle(shape: WidgetStatePropertyAll(_roundedBorder(8)));

  static RoundedRectangleBorder _roundedBorder(double radius) =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}

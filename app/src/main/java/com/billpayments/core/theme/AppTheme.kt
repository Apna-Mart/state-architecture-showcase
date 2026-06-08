package com.billpayments.core.theme

import android.app.Activity
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Shapes
import androidx.compose.material3.Typography
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalView
import androidx.core.view.WindowCompat
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.billpayments.R
import com.billpayments.features.settings.data.AppThemeMode

val BrandBlue = Color(0xFF11448A)
val BrandBlueLight = Color(0xFF3161AD)
val BrandYellow = Color(0xFFFACC15)
val BrandYellowSoft = Color(0xFFFFCA49)

private val Rubik = FontFamily(Font(R.font.rubik))

private val LightColors = lightColorScheme(
    primary = BrandBlue,
    onPrimary = Color.White,
    secondary = BrandYellow,
    onSecondary = BrandBlue,
    tertiary = BrandYellowSoft,
    onTertiary = BrandBlue,
)

private val DarkColors = darkColorScheme(
    primary = BrandBlueLight,
    onPrimary = Color.White,
    secondary = BrandYellow,
    onSecondary = BrandBlue,
    tertiary = BrandYellowSoft,
    onTertiary = BrandBlue,
)

private fun rubikTypography(): Typography {
    val base = Typography()
    return Typography(
        displayLarge = base.displayLarge.copy(fontFamily = Rubik),
        displayMedium = base.displayMedium.copy(fontFamily = Rubik),
        displaySmall = base.displaySmall.copy(fontFamily = Rubik),
        headlineLarge = base.headlineLarge.copy(fontFamily = Rubik, fontWeight = FontWeight.W700),
        headlineMedium = base.headlineMedium.copy(fontFamily = Rubik, fontWeight = FontWeight.W700),
        headlineSmall = base.headlineSmall.copy(fontFamily = Rubik, fontWeight = FontWeight.W700),
        titleLarge = base.titleLarge.copy(fontFamily = Rubik, fontWeight = FontWeight.W700),
        titleMedium = base.titleMedium.copy(fontFamily = Rubik),
        titleSmall = base.titleSmall.copy(fontFamily = Rubik),
        bodyLarge = base.bodyLarge.copy(fontFamily = Rubik),
        bodyMedium = base.bodyMedium.copy(fontFamily = Rubik),
        bodySmall = base.bodySmall.copy(fontFamily = Rubik),
        labelLarge = base.labelLarge.copy(fontFamily = Rubik),
        labelMedium = base.labelMedium.copy(fontFamily = Rubik),
        labelSmall = base.labelSmall.copy(fontFamily = Rubik),
    )
}

private val AppShapes = Shapes(
    small = RoundedCornerShape(8.dp),
    medium = RoundedCornerShape(12.dp),
    large = RoundedCornerShape(12.dp),
)

@Composable
fun BillPaymentsTheme(themeMode: AppThemeMode, content: @Composable () -> Unit) {
    val dark = when (themeMode) {
        AppThemeMode.System -> isSystemInDarkTheme()
        AppThemeMode.Light -> false
        AppThemeMode.Dark -> true
    }
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as Activity).window
            val controller = WindowCompat.getInsetsController(window, view)
            controller.isAppearanceLightStatusBars = !dark
            controller.isAppearanceLightNavigationBars = !dark
        }
    }
    MaterialTheme(
        colorScheme = if (dark) DarkColors else LightColors,
        typography = rubikTypography(),
        shapes = AppShapes,
        content = content,
    )
}

package com.billpayments.features.settings.data

enum class AppThemeMode { System, Light, Dark }

data class AppSettings(
    val themeMode: AppThemeMode,
)

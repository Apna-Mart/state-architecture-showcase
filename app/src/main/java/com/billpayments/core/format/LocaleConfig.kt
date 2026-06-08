package com.billpayments.core.format

data class LocaleConfig(
    val numberLocale: String,
    val dateLocale: String,
    val currencySymbol: String,
)

val localeConfigs = mapOf(
    "en" to LocaleConfig(numberLocale = "en-IN", dateLocale = "en", currencySymbol = "₹"),
    "hi" to LocaleConfig(numberLocale = "hi", dateLocale = "hi", currencySymbol = "₹"),
    "ar" to LocaleConfig(numberLocale = "ar-EG", dateLocale = "ar-EG", currencySymbol = "₹"),
)

fun configFor(language: String): LocaleConfig = localeConfigs[language] ?: localeConfigs.getValue("en")

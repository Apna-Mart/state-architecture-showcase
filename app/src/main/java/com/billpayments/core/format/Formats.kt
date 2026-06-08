package com.billpayments.core.format

import java.text.NumberFormat
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit
import java.util.Locale

fun formatPaise(paise: Long, language: String): String {
    val config = configFor(language)
    val format = NumberFormat.getNumberInstance(Locale.forLanguageTag(config.numberLocale)).apply {
        minimumFractionDigits = 2
        maximumFractionDigits = 2
    }
    return "${config.currencySymbol}${format.format(paise / 100.0)}"
}

fun formatDate(date: LocalDate, language: String): String {
    val locale = Locale.forLanguageTag(configFor(language).dateLocale)
    return date.format(DateTimeFormatter.ofPattern("d MMM yyyy", locale))
}

fun daysUntilDue(due: LocalDate, today: LocalDate): Int =
    ChronoUnit.DAYS.between(today, due).toInt()

package com.billpayments.core.format

import java.time.LocalDate
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class FormatsTest {

    @Test
    fun formatsPaiseAsIndianGroupedRupeesForEnglish() {
        val formatted = formatPaise(12345678L, "en")
        assertTrue(formatted.startsWith("₹"))
        assertTrue(formatted.endsWith("456.78"))
        assertTrue(formatted.contains(","))
    }

    @Test
    fun formatsPaiseWithTwoDecimals() {
        assertEquals("₹500.00", formatPaise(50000L, "en"))
    }

    @Test
    fun unknownLanguageFallsBackToEnglish() {
        assertEquals(formatPaise(50000L, "en"), formatPaise(50000L, "xx"))
    }

    @Test
    fun arabicUsesArabicDigits() {
        val formatted = formatPaise(50000L, "ar")
        assertTrue(formatted.contains('٥'))
    }

    @Test
    fun daysUntilDueIgnoresTimeOfDay() {
        assertEquals(3, daysUntilDue(LocalDate.of(2026, 6, 10), LocalDate.of(2026, 6, 7)))
        assertEquals(-2, daysUntilDue(LocalDate.of(2026, 6, 5), LocalDate.of(2026, 6, 7)))
    }
}

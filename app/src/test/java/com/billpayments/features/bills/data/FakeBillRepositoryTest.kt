package com.billpayments.features.bills.data

import com.billpayments.core.mock.MockNetwork
import com.billpayments.features.saved_billers.data.SavedBiller
import java.time.Instant
import java.time.ZoneId
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class FakeBillRepositoryTest {

    private val clock = com.billpayments.core.time.Clock { Instant.parse("2026-06-07T10:00:00Z") }
    private val repository = FakeBillRepository(MockNetwork(0, 0), clock)

    @Test
    fun billIsDeterministicPerBillerAndAccount() = runTest {
        val first = repository.fetchBill("electricity-national", "12345")
        val second = repository.fetchBill("electricity-national", "12345")
        assertEquals(first, second)
    }

    @Test
    fun amountDerivedFromSeedWithinRange() = runTest {
        val bill = repository.fetchBill("electricity-national", "12345")
        assertTrue(bill.amountPaise in 20_000L..470_000L)
        assertEquals(0L, bill.amountPaise % 100)
    }

    @Test
    fun dueDateWithinMinus3ToPlus11DaysOfToday() = runTest {
        val today = clock.now().atZone(ZoneId.systemDefault()).toLocalDate()
        val bill = repository.fetchBill("water-metro", "999")
        val offset = java.time.temporal.ChronoUnit.DAYS.between(today, bill.dueDate)
        assertTrue(offset in -3..11)
    }

    @Test
    fun fetchDueBillsReturnsOnePerSavedBiller() = runTest {
        val saved = listOf(
            SavedBiller("electricity-national", "1", "A"),
            SavedBiller("water-metro", "2", "B"),
        )
        assertEquals(2, repository.fetchDueBills(saved).size)
    }
}

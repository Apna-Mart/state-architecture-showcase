package com.billpayments.core.mock

import kotlinx.coroutines.test.currentTime
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class MockNetworkTest {

    @Test
    fun nextDelayStaysWithinBounds() {
        val network = MockNetwork(minDelayMs = 300, maxDelayMs = 800)
        repeat(100) {
            val delay = network.nextDelayMs()
            assertTrue(delay in 300 until 800)
        }
    }

    @Test
    fun failsExactlyEveryNthCall() {
        val network = MockNetwork(failEvery = 3)
        network.countAndMaybeFail()
        network.countAndMaybeFail()
        assertThrows(MockPaymentDeclined::class.java) { network.countAndMaybeFail() }
        network.countAndMaybeFail()
    }

    @Test
    fun zeroDelayNetworkCompletesImmediately() = runTest {
        val network = MockNetwork(minDelayMs = 0, maxDelayMs = 0)
        network.delay()
        assertEquals(0, currentTime)
    }
}

package com.billpayments.core.event

import app.cash.turbine.test
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Test

class UiEventBusTest {

    @Test
    fun deliversEmittedEventsInOrder() = runTest {
        val bus = UiEventBus()
        bus.events.test {
            bus.emit(UiEvent.PaymentStarted("pay-1"))
            bus.emit(UiEvent.OtpRejected)
            assertEquals(UiEvent.PaymentStarted("pay-1"), awaitItem())
            assertEquals(UiEvent.OtpRejected, awaitItem())
        }
    }

    @Test
    fun buffersEventsEmittedBeforeCollection() = runTest {
        val bus = UiEventBus()
        bus.emit(UiEvent.StorageFailed)
        bus.events.test {
            assertEquals(UiEvent.StorageFailed, awaitItem())
        }
    }
}

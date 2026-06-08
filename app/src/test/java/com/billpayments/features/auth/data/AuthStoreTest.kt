package com.billpayments.features.auth.data

import app.cash.turbine.test
import com.billpayments.core.event.UiEvent
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class AuthStoreTest {

    private fun store(
        keyValueStore: InMemoryKeyValueStore = InMemoryKeyValueStore(),
        bus: UiEventBus = UiEventBus(),
        scope: CoroutineScope,
    ) = AuthStore(
        authRepository = FakeAuthRepository(MockNetwork(0, 0)),
        sessionRepository = StoredSessionRepository(keyValueStore),
        events = bus,
        scope = scope,
    )

    @Test
    fun startsUnauthenticatedWithoutSession() = runTest {
        assertEquals(Auth.Unauthenticated, store(scope = storeScope()).state.value)
    }

    @Test
    fun fullOtpFlowAuthenticates() = runTest {
        val auth = store(scope = storeScope())
        auth.sendOtp("9876543210")
        assertEquals(Auth.SendingOtp("9876543210"), auth.state.value)
        advanceUntilIdle()
        assertEquals(Auth.OtpSent("9876543210"), auth.state.value)
        auth.verifyOtp("123456")
        assertEquals(Auth.Verifying("9876543210"), auth.state.value)
        advanceUntilIdle()
        assertEquals(Auth.Authenticated("user-9876543210", "9876543210"), auth.state.value)
    }

    @Test
    fun sendOtpIgnoredWhileSending() = runTest {
        val auth = store(scope = storeScope())
        auth.sendOtp("9876543210")
        auth.sendOtp("1111111111")
        assertEquals(Auth.SendingOtp("9876543210"), auth.state.value)
    }

    @Test
    fun verifyOtpIgnoredUnlessOtpSent() = runTest {
        val auth = store(scope = storeScope())
        auth.verifyOtp("123456")
        assertEquals(Auth.Unauthenticated, auth.state.value)
    }

    @Test
    fun invalidOtpReturnsToOtpSentAndEmitsOtpRejected() = runTest {
        val bus = UiEventBus()
        val auth = store(bus = bus, scope = storeScope())
        auth.sendOtp("9876543210")
        advanceUntilIdle()
        bus.events.test {
            auth.verifyOtp("12")
            advanceUntilIdle()
            assertEquals(Auth.OtpSent("9876543210"), auth.state.value)
            assertEquals(UiEvent.OtpRejected, awaitItem())
        }
    }

    @Test
    fun sessionRestoredByFreshStoreGraph() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val first = store(keyValueStore = keyValueStore, scope = storeScope())
        first.sendOtp("9876543210")
        advanceUntilIdle()
        first.verifyOtp("123456")
        advanceUntilIdle()
        val second = store(keyValueStore = keyValueStore, scope = storeScope())
        assertEquals(Auth.Authenticated("user-9876543210", "9876543210"), second.state.value)
    }

    @Test
    fun logoutClearsSession() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val auth = store(keyValueStore = keyValueStore, scope = storeScope())
        auth.sendOtp("9876543210")
        advanceUntilIdle()
        auth.verifyOtp("123456")
        advanceUntilIdle()
        auth.logout()
        advanceUntilIdle()
        assertEquals(Auth.Unauthenticated, auth.state.value)
        assertTrue(StoredSessionRepository(keyValueStore).restore() == null)
    }
}

private fun TestScope.storeScope(): CoroutineScope =
    CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

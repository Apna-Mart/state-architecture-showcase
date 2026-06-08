package com.billpayments.features.saved_billers.data

import app.cash.turbine.test
import com.billpayments.core.event.UiEvent
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.FakeAuthRepository
import com.billpayments.features.auth.data.StoredSessionRepository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Test

class SavedBillersStoreTest {

    private val biller = SavedBiller("electricity-national", "12345", "Home")

    private fun authedStore(
        keyValueStore: InMemoryKeyValueStore,
        bus: UiEventBus,
        scope: CoroutineScope,
    ): AuthStore = AuthStore(
        FakeAuthRepository(MockNetwork(0, 0)),
        StoredSessionRepository(keyValueStore),
        bus,
        scope,
    )

    private suspend fun TestScope.login(auth: AuthStore) {
        auth.sendOtp("9876543210")
        advanceUntilIdle()
        auth.verifyOtp("123456")
        advanceUntilIdle()
    }

    @Test
    fun saveAddsAndPersistsPerUser() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val auth = authedStore(keyValueStore, bus, storeScope())
        login(auth)
        val store = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, storeScope())
        advanceUntilIdle()
        store.save(biller)
        advanceUntilIdle()
        assertEquals(listOf(biller), store.state.value.items)
        val restored = StoredSavedBillersRepository(keyValueStore).restore("user-9876543210")
        assertEquals(listOf(biller), restored.items)
    }

    @Test
    fun duplicateSaveIgnored() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val auth = authedStore(keyValueStore, bus, storeScope())
        login(auth)
        val store = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, storeScope())
        advanceUntilIdle()
        store.save(biller)
        advanceUntilIdle()
        store.save(biller.copy(nickname = "Other"))
        advanceUntilIdle()
        assertEquals(1, store.state.value.items.size)
    }

    @Test
    fun persistFailureRollsBackAndEmitsStorageFailed() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val auth = authedStore(keyValueStore, bus, storeScope())
        login(auth)
        val store = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, storeScope())
        advanceUntilIdle()
        keyValueStore.failWrites = true
        bus.events.test {
            store.save(biller)
            assertEquals(listOf(biller), store.state.value.items)
            advanceUntilIdle()
            assertEquals(emptyList<SavedBiller>(), store.state.value.items)
            assertEquals(UiEvent.StorageFailed, awaitItem())
        }
    }

    @Test
    fun logoutResetsToEmpty() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val auth = authedStore(keyValueStore, bus, storeScope())
        login(auth)
        val store = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, storeScope())
        advanceUntilIdle()
        store.save(biller)
        advanceUntilIdle()
        auth.logout()
        advanceUntilIdle()
        assertEquals(SavedBillers.EMPTY, store.state.value)
    }
}

private fun TestScope.storeScope(): CoroutineScope =
    CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

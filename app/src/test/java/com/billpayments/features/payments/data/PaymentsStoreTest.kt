package com.billpayments.features.payments.data

import app.cash.turbine.test
import com.billpayments.core.async.valueOrNull
import com.billpayments.core.event.UiEvent
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.core.time.Clock
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.FakeAuthRepository
import com.billpayments.features.auth.data.StoredSessionRepository
import com.billpayments.features.bills.data.DueBillsStore
import com.billpayments.features.bills.data.FakeBillRepository
import com.billpayments.features.saved_billers.data.SavedBillersStore
import com.billpayments.features.saved_billers.data.StoredSavedBillersRepository
import java.time.Instant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

private fun TestScope.storeScope(): CoroutineScope =
    CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

class PaymentsStoreTest {

    private class Fixture(
        scope: CoroutineScope,
        val keyValueStore: InMemoryKeyValueStore = InMemoryKeyValueStore(),
        paymentNetwork: MockNetwork = MockNetwork(0, 0, failEvery = 1000),
    ) {
        val bus = UiEventBus()
        val clock = Clock { Instant.parse("2026-06-07T10:00:00Z") }
        val auth = AuthStore(FakeAuthRepository(MockNetwork(0, 0)), StoredSessionRepository(keyValueStore), bus, scope)
        val saved = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, scope)
        val dueBills = DueBillsStore(auth, saved, FakeBillRepository(MockNetwork(0, 0), clock), clock, scope)
        val store = PaymentsStore(
            auth, FakePaymentRepository(paymentNetwork), StoredPaymentHistoryRepository(keyValueStore),
            dueBills, bus, clock, scope,
        )
    }

    private suspend fun TestScope.login(fixture: Fixture) {
        fixture.auth.sendOtp("9876543210")
        advanceUntilIdle()
        fixture.auth.verifyOtp("123456")
        advanceUntilIdle()
    }

    private fun pay(fixture: Fixture) = fixture.store.pay(
        billerId = "electricity-national",
        billerName = "National Electricity",
        categoryId = "electricity",
        account = "12345",
        amountPaise = 50_000L,
    )

    @Test
    fun successfulPaymentTransitionsProcessingToSuccess() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        fixture.bus.events.test {
            pay(fixture)
            assertEquals(PaymentStatus.Processing, fixture.store.state.value.items.single().status)
            assertEquals(UiEvent.PaymentStarted("pay-1"), awaitItem())
            advanceUntilIdle()
            assertEquals(PaymentStatus.Success, fixture.store.state.value.items.single().status)
        }
    }

    @Test
    fun declinedPaymentTransitionsToFailedAndEmits() = runTest {
        val fixture = Fixture(storeScope(), paymentNetwork = MockNetwork(0, 0, failEvery = 1))
        login(fixture)
        fixture.bus.events.test {
            pay(fixture)
            assertEquals(UiEvent.PaymentStarted("pay-1"), awaitItem())
            advanceUntilIdle()
            assertEquals(PaymentStatus.Failed, fixture.store.state.value.items.single().status)
            assertEquals(UiEvent.PaymentFailed("pay-1"), awaitItem())
        }
    }

    @Test
    fun duplicatePayForSameBillerAccountIgnoredWhileProcessing() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        pay(fixture)
        pay(fixture)
        assertEquals(1, fixture.store.state.value.items.size)
        advanceUntilIdle()
    }

    @Test
    fun paymentsPersistAndRestoreAcrossStoreGraphs() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val fixture = Fixture(storeScope(), keyValueStore)
        login(fixture)
        pay(fixture)
        advanceUntilIdle()
        val restored = StoredPaymentHistoryRepository(keyValueStore).restore("user-9876543210")
        assertEquals(1, restored.items.size)
        assertEquals(PaymentStatus.Success, restored.items.single().status)
        assertEquals(2, restored.nextId)
    }

    @Test
    fun interruptedProcessingRestoresAsFailed() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val repository = StoredPaymentHistoryRepository(keyValueStore)
        val processing = Payment(
            "pay-1", "electricity-national", "National Electricity", "electricity",
            "12345", 50_000L, Instant.parse("2026-06-07T09:00:00Z"), PaymentStatus.Processing,
        )
        repository.persist("user-9876543210", Payments(listOf(processing), 2))
        val restored = repository.restore("user-9876543210")
        assertEquals(PaymentStatus.Failed, restored.items.single().status)
    }

    @Test
    fun logoutDuringPaymentDiscardsStaleCompletion() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        pay(fixture)
        fixture.auth.logout()
        advanceUntilIdle()
        assertTrue(fixture.store.state.value.items.isEmpty())
    }

    @Test
    fun successfulPaymentInvalidatesDueBills() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        fixture.saved.save(com.billpayments.features.saved_billers.data.SavedBiller("electricity-national", "12345", "Home"))
        advanceUntilIdle()
        val before = fixture.dueBills.dueBills.value.valueOrNull
        pay(fixture)
        advanceUntilIdle()
        assertEquals(before, fixture.dueBills.dueBills.value.valueOrNull)
    }
}

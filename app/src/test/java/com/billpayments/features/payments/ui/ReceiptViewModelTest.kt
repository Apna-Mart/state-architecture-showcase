package com.billpayments.features.payments.ui

import app.cash.turbine.test
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.core.time.Clock
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.FakeAuthRepository
import com.billpayments.features.auth.data.StoredSessionRepository
import com.billpayments.features.bills.data.DueBillsStore
import com.billpayments.features.bills.data.FakeBillRepository
import com.billpayments.features.payments.data.FakePaymentRepository
import com.billpayments.features.payments.data.PaymentsStore
import com.billpayments.features.payments.data.StoredPaymentHistoryRepository
import com.billpayments.features.saved_billers.data.SavedBiller
import com.billpayments.features.saved_billers.data.SavedBillersStore
import com.billpayments.features.saved_billers.data.StoredSavedBillersRepository
import com.billpayments.testing.MainDispatcherRule
import java.time.Instant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test

class ReceiptViewModelTest {

    @get:Rule
    val mainDispatcherRule = MainDispatcherRule()

    private fun TestScope.storeScope(): CoroutineScope =
        CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

    private inner class Fixture(scope: CoroutineScope, paymentNetwork: MockNetwork = MockNetwork(0, 0, failEvery = 1000)) {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val clock = Clock { Instant.parse("2026-06-07T10:00:00Z") }
        val auth = AuthStore(FakeAuthRepository(MockNetwork(0, 0)), StoredSessionRepository(keyValueStore), bus, scope)
        val saved = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, scope)
        val dueBills = DueBillsStore(auth, saved, FakeBillRepository(MockNetwork(0, 0), clock), clock, scope)
        val payments = PaymentsStore(
            auth, FakePaymentRepository(paymentNetwork),
            StoredPaymentHistoryRepository(keyValueStore), dueBills, bus, clock, scope,
        )

        fun pay() = payments.pay("electricity-national", "National Electricity", "electricity", "12345", 50_000L)
    }

    private suspend fun TestScope.login(fixture: Fixture) {
        fixture.auth.sendOtp("9876543210")
        advanceUntilIdle()
        fixture.auth.verifyOtp("123456")
        advanceUntilIdle()
    }

    @Test
    fun unknownPaymentIsNotFound() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        val viewModel = ReceiptViewModel("pay-99", fixture.payments, fixture.saved)
        viewModel.screenData.test {
            advanceUntilIdle()
            assertEquals(ReceiptScreenData.NotFound, expectMostRecentItem())
        }
    }

    @Test
    fun processingPaymentProjectsProcessing() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        fixture.pay()
        val viewModel = ReceiptViewModel("pay-1", fixture.payments, fixture.saved)
        assertTrue(viewModel.screenData.value is ReceiptScreenData.Processing)
        advanceUntilIdle()
    }

    @Test
    fun successProjectsSuccessWithSaveBillerOffer() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        fixture.pay()
        advanceUntilIdle()
        val viewModel = ReceiptViewModel("pay-1", fixture.payments, fixture.saved)
        viewModel.screenData.test {
            advanceUntilIdle()
            val success = expectMostRecentItem() as ReceiptScreenData.Success
            assertTrue(success.canSaveBiller)
            viewModel.saveBiller("Home")
            advanceUntilIdle()
            val updated = expectMostRecentItem() as ReceiptScreenData.Success
            assertEquals(false, updated.canSaveBiller)
            assertEquals(listOf(SavedBiller("electricity-national", "12345", "Home")), fixture.saved.state.value.items)
        }
    }

    @Test
    fun failureProjectsFailedWithRetry() = runTest {
        val fixture = Fixture(storeScope(), paymentNetwork = MockNetwork(0, 0, failEvery = 1))
        login(fixture)
        fixture.pay()
        advanceUntilIdle()
        val viewModel = ReceiptViewModel("pay-1", fixture.payments, fixture.saved)
        viewModel.screenData.test {
            advanceUntilIdle()
            assertTrue(expectMostRecentItem() is ReceiptScreenData.Failed)
        }
    }
}

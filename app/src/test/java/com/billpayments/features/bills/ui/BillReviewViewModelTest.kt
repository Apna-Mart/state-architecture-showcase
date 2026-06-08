package com.billpayments.features.bills.ui

import app.cash.turbine.test
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.core.time.Clock
import com.billpayments.core.time.DateStream
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.FakeAuthRepository
import com.billpayments.features.auth.data.StoredSessionRepository
import com.billpayments.features.billers.data.BillerCatalogStore
import com.billpayments.features.billers.data.FakeBillerRepository
import com.billpayments.features.bills.data.DueBillsStore
import com.billpayments.features.bills.data.FakeBillRepository
import com.billpayments.features.payments.data.FakePaymentRepository
import com.billpayments.features.payments.data.PaymentsStore
import com.billpayments.features.payments.data.StoredPaymentHistoryRepository
import com.billpayments.features.saved_billers.data.SavedBillersStore
import com.billpayments.features.saved_billers.data.StoredSavedBillersRepository
import com.billpayments.features.settings.data.SettingsStore
import com.billpayments.features.settings.data.StoredSettingsRepository
import com.billpayments.testing.MainDispatcherRule
import java.time.Instant
import java.time.ZoneId
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runCurrent
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test

class BillReviewViewModelTest {

    @get:Rule
    val mainDispatcherRule = MainDispatcherRule()

    private fun TestScope.storeScope(): CoroutineScope =
        CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

    private inner class Fixture(
        scope: CoroutineScope,
        paymentNetwork: MockNetwork = MockNetwork(0, 0, failEvery = 1000),
    ) {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val clock = Clock { Instant.parse("2026-06-07T10:00:00Z") }
        val auth = AuthStore(FakeAuthRepository(MockNetwork(0, 0)), StoredSessionRepository(keyValueStore), bus, scope)
        val settings = SettingsStore(StoredSettingsRepository(keyValueStore), { "en" }, scope)
        val catalog = BillerCatalogStore(FakeBillerRepository(MockNetwork(0, 0)), settings, clock, scope)
        val saved = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, scope)
        val billRepository = FakeBillRepository(MockNetwork(0, 0), clock)
        val dueBills = DueBillsStore(auth, saved, billRepository, clock, scope)
        val payments = PaymentsStore(
            auth, FakePaymentRepository(paymentNetwork),
            StoredPaymentHistoryRepository(keyValueStore), dueBills, bus, clock, scope,
        )

        val dateStream = DateStream { flowOf(clock.now().atZone(ZoneId.systemDefault()).toLocalDate()) }

        fun reviewViewModel(billerId: String, account: String, amountPaise: Long?) =
            BillReviewViewModel(billerId, account, amountPaise, catalog, billRepository, payments, dateStream)
    }

    private suspend fun TestScope.login(fixture: Fixture) {
        fixture.auth.sendOtp("9876543210")
        advanceUntilIdle()
        fixture.auth.verifyOtp("123456")
        advanceUntilIdle()
    }

    @Test
    fun openAmountReviewUsesPassedAmountWithoutFetch() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        val viewModel = fixture.reviewViewModel("dth-metro", "SUB99", 25050L)
        viewModel.screenData.test {
            advanceUntilIdle()
            val review = expectMostRecentItem() as BillReviewScreenData.Review
            assertEquals(25050L, review.amountPaise)
            assertNull(review.customerName)
            assertNull(review.dueInDays)
            assertTrue(review.canPay)
        }
    }

    @Test
    fun presentmentReviewFetchesBillDetails() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        val viewModel = fixture.reviewViewModel("electricity-national", "12345", null)
        viewModel.screenData.test {
            advanceUntilIdle()
            val review = expectMostRecentItem() as BillReviewScreenData.Review
            assertTrue(review.amountPaise > 0)
            assertTrue(review.customerName != null)
        }
    }

    @Test
    fun openAmountWithoutAmountIsError() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        val viewModel = fixture.reviewViewModel("dth-metro", "SUB99", null)
        viewModel.screenData.test {
            advanceUntilIdle()
            assertTrue(expectMostRecentItem() is BillReviewScreenData.Error)
        }
    }

    @Test
    fun payingDisablesPayButton() = runTest {
        val fixture = Fixture(storeScope(), MockNetwork(100_000, 100_001, failEvery = 1000))
        login(fixture)
        val viewModel = fixture.reviewViewModel("dth-metro", "SUB99", 25050L)
        viewModel.screenData.test {
            advanceUntilIdle()
            expectMostRecentItem()
            viewModel.pay()
            runCurrent()
            val review = expectMostRecentItem() as BillReviewScreenData.Review
            assertTrue(review.paying)
            assertEquals(false, review.canPay)
            advanceUntilIdle()
            cancelAndIgnoreRemainingEvents()
        }
    }
}

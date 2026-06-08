package com.billpayments.features.bills.ui

import androidx.lifecycle.SavedStateHandle
import app.cash.turbine.test
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.nav.BillReviewKey
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.features.billers.data.BillerCatalogStore
import com.billpayments.features.billers.data.FakeBillerRepository
import com.billpayments.features.settings.data.SettingsStore
import com.billpayments.features.settings.data.StoredSettingsRepository
import com.billpayments.testing.MainDispatcherRule
import java.time.Instant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test

class BillFetchViewModelTest {

    @get:Rule
    val mainDispatcherRule = MainDispatcherRule()

    private fun TestScope.storeScope(): CoroutineScope =
        CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

    private fun TestScope.catalog(): BillerCatalogStore {
        val settings = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { "en" }, storeScope())
        return BillerCatalogStore(FakeBillerRepository(MockNetwork(0, 0)), settings, { Instant.EPOCH }, storeScope())
    }

    @Test
    fun presentmentBillerShowsFetchActionGatedOnFields() = runTest {
        val viewModel = BillFetchViewModel("electricity-national", catalog(), SavedStateHandle())
        viewModel.screenData.test {
            advanceUntilIdle()
            val form = expectMostRecentItem() as BillFetchScreenData.Form
            assertEquals(FetchSubmitAction.FetchBill, form.submit.action)
            assertNull(form.submit.reviewKey)
            viewModel.editField("account", "12345")
            advanceUntilIdle()
            val ready = expectMostRecentItem() as BillFetchScreenData.Form
            assertEquals(
                BillReviewKey("electricity-national", "12345", null),
                ready.submit.reviewKey,
            )
        }
    }

    @Test
    fun openAmountBillerRequiresPositiveAmount() = runTest {
        val viewModel = BillFetchViewModel("dth-metro", catalog(), SavedStateHandle())
        viewModel.screenData.test {
            advanceUntilIdle()
            viewModel.editField("account", "SUB99")
            advanceUntilIdle()
            assertNull((expectMostRecentItem() as BillFetchScreenData.Form).submit.reviewKey)
            viewModel.editAmount("250.50")
            advanceUntilIdle()
            val ready = expectMostRecentItem() as BillFetchScreenData.Form
            assertEquals(FetchSubmitAction.ContinueToReview, ready.submit.action)
            assertEquals(BillReviewKey("dth-metro", "SUB99", 25050L), ready.submit.reviewKey)
        }
    }

    @Test
    fun creditCardJoinsTwoFieldsWithPipe() = runTest {
        val viewModel = BillFetchViewModel("credit-card-city", catalog(), SavedStateHandle())
        viewModel.screenData.test {
            advanceUntilIdle()
            viewModel.editField("card", "4321")
            viewModel.editField("mobile", "9876543210")
            advanceUntilIdle()
            val ready = expectMostRecentItem() as BillFetchScreenData.Form
            assertEquals("4321|9876543210", ready.submit.reviewKey!!.account)
        }
    }

    @Test
    fun unknownBillerYieldsError() = runTest {
        val viewModel = BillFetchViewModel("nope", catalog(), SavedStateHandle())
        viewModel.screenData.test {
            advanceUntilIdle()
            assertTrue(expectMostRecentItem() is BillFetchScreenData.Error)
        }
    }
}

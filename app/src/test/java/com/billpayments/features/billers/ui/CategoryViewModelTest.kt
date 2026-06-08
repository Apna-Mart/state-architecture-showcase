package com.billpayments.features.billers.ui

import app.cash.turbine.test
import com.billpayments.core.mock.MockNetwork
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
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test

class CategoryViewModelTest {

    @get:Rule
    val mainDispatcherRule = MainDispatcherRule()

    private fun TestScope.storeScope(): CoroutineScope =
        CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

    private fun TestScope.catalog(): BillerCatalogStore {
        val settings = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { "en" }, storeScope())
        return BillerCatalogStore(FakeBillerRepository(MockNetwork(0, 0)), settings, { Instant.EPOCH }, storeScope())
    }

    @Test
    fun loadsFourBillersForCategory() = runTest {
        val viewModel = CategoryViewModel("electricity", catalog())
        advanceUntilIdle()
        viewModel.screenData.test {
            advanceUntilIdle()
            val data = expectMostRecentItem()
            assertTrue(data is CategoryScreenData.Loaded)
            assertEquals(4, (data as CategoryScreenData.Loaded).billers.size)
            assertEquals("Electricity", data.categoryName)
        }
    }

    @Test
    fun unknownCategoryYieldsError() = runTest {
        val viewModel = CategoryViewModel("nope", catalog())
        advanceUntilIdle()
        viewModel.screenData.test {
            advanceUntilIdle()
            assertTrue(expectMostRecentItem() is CategoryScreenData.Error)
        }
    }
}

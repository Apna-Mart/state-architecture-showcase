package com.billpayments.features.billers.ui

import androidx.lifecycle.SavedStateHandle
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

class SearchViewModelTest {

    @get:Rule
    val mainDispatcherRule = MainDispatcherRule()

    private fun TestScope.storeScope(): CoroutineScope =
        CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

    private inner class Fixture(scope: CoroutineScope, catalogScope: CoroutineScope) {
        var systemLanguage = "en"
        val settings = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { systemLanguage }, scope)
        val repository = FakeBillerRepository(MockNetwork(0, 0))
        val catalog = BillerCatalogStore(repository, settings, { Instant.EPOCH }, catalogScope)
        val viewModel = SearchViewModel(repository, catalog, settings, SavedStateHandle())
    }

    private fun TestScope.fixture(): Fixture = Fixture(storeScope(), storeScope())

    @Test
    fun shortQueryStaysIdle() = runTest {
        val viewModel = fixture().viewModel
        viewModel.screenData.test {
            assertEquals(SearchScreenData.Idle, awaitItem())
            viewModel.editQuery("m")
            advanceUntilIdle()
            expectNoEvents()
        }
    }

    @Test
    fun queryYieldsMatchingResultsWithCategoryNames() = runTest {
        val viewModel = fixture().viewModel
        advanceUntilIdle()
        viewModel.screenData.test {
            awaitItem()
            viewModel.editQuery("metro")
            assertEquals(SearchScreenData.Searching, awaitItem())
            advanceUntilIdle()
            val results = expectMostRecentItem()
            assertTrue(results is SearchScreenData.Results)
            assertEquals(15, (results as SearchScreenData.Results).billers.size)
            assertEquals("Electricity", results.billers.first { it.id == "electricity-metro" }.categoryName)
        }
    }

    @Test
    fun noMatchYieldsEmptyWithQuery() = runTest {
        val viewModel = fixture().viewModel
        advanceUntilIdle()
        viewModel.screenData.test {
            awaitItem()
            viewModel.editQuery("zzzz")
            advanceUntilIdle()
            assertEquals(SearchScreenData.Empty("zzzz"), expectMostRecentItem())
        }
    }

    @Test
    fun languageChangeRefetchesResults() = runTest {
        val fixture = fixture()
        advanceUntilIdle()
        fixture.viewModel.screenData.test {
            awaitItem()
            fixture.viewModel.editQuery("metro")
            advanceUntilIdle()
            assertTrue(expectMostRecentItem() is SearchScreenData.Results)
            fixture.systemLanguage = "hi"
            fixture.settings.refreshLanguage()
            var item = awaitItem()
            while (item != SearchScreenData.Searching) item = awaitItem()
            advanceUntilIdle()
            cancelAndIgnoreRemainingEvents()
        }
    }
}

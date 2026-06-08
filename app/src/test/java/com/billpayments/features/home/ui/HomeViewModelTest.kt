package com.billpayments.features.home.ui

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
import com.billpayments.features.saved_billers.data.SavedBiller
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
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test

class HomeViewModelTest {

    @get:Rule
    val mainDispatcherRule = MainDispatcherRule()

    private fun TestScope.storeScope(): CoroutineScope =
        CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

    private inner class Fixture(scope: CoroutineScope) {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val clock = Clock { Instant.parse("2026-06-07T10:00:00Z") }
        val auth = AuthStore(FakeAuthRepository(MockNetwork(0, 0)), StoredSessionRepository(keyValueStore), bus, scope)
        val settings = SettingsStore(StoredSettingsRepository(keyValueStore), { "en" }, scope)
        val catalog = BillerCatalogStore(FakeBillerRepository(MockNetwork(0, 0)), settings, clock, scope)
        val saved = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, scope)
        val dueBills = DueBillsStore(auth, saved, FakeBillRepository(MockNetwork(0, 0), clock), clock, scope)
        val dateStream = DateStream { flowOf(clock.now().atZone(ZoneId.systemDefault()).toLocalDate()) }
        val viewModel = HomeViewModel(catalog, saved, dueBills, dateStream)
    }

    private suspend fun TestScope.login(fixture: Fixture) {
        fixture.auth.sendOtp("9876543210")
        advanceUntilIdle()
        fixture.auth.verifyOtp("123456")
        advanceUntilIdle()
    }

    @Test
    fun categoriesLoadFromCatalog() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        advanceUntilIdle()
        fixture.viewModel.categories.test {
            advanceUntilIdle()
            val categories = expectMostRecentItem()
            assertTrue(categories is HomeCategoriesData.Loaded)
            assertEquals(15, (categories as HomeCategoriesData.Loaded).items.size)
        }
    }

    @Test
    fun remindersExcludeOpenAmountBillers() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        fixture.saved.save(SavedBiller("electricity-national", "12345", "Home"))
        fixture.saved.save(SavedBiller("dth-metro", "777", "TV"))
        advanceUntilIdle()
        fixture.viewModel.reminders.test {
            advanceUntilIdle()
            val reminders = expectMostRecentItem()
            assertTrue(reminders is HomeRemindersData.Loaded)
            assertEquals(listOf("electricity-national"), (reminders as HomeRemindersData.Loaded).items.map { it.billerId })
        }
    }

    @Test
    fun savedBillersSectionDoesNotEmitWhenRemindersRefetch() = runTest {
        val fixture = Fixture(storeScope())
        login(fixture)
        fixture.saved.save(SavedBiller("electricity-national", "12345", "Home"))
        advanceUntilIdle()
        fixture.viewModel.savedBillers.test {
            advanceUntilIdle()
            expectMostRecentItem()
            fixture.dueBills.invalidate()
            advanceUntilIdle()
            expectNoEvents()
        }
    }
}

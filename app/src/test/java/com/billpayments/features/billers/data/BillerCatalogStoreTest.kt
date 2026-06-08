package com.billpayments.features.billers.data

import com.billpayments.core.async.Async
import com.billpayments.core.async.valueOrNull
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.core.time.Clock
import com.billpayments.features.settings.data.SettingsStore
import com.billpayments.features.settings.data.StoredSettingsRepository
import java.time.Duration
import java.time.Instant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Test

private fun TestScope.storeScope(): CoroutineScope =
    CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

class BillerCatalogStoreTest {

    private fun TestScope.settings(): SettingsStore =
        SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { "en" }, storeScope())

    @Test
    fun loadsCatalogWith60BillersAnd15Categories() = runTest {
        val store = BillerCatalogStore(FakeBillerRepository(MockNetwork(0, 0)), settings(), { Instant.EPOCH }, storeScope())
        advanceUntilIdle()
        val catalog = store.catalog.value.valueOrNull
        assertNotNull(catalog)
        assertEquals(15, catalog!!.categories.size)
        assertEquals(60, catalog.billers.size)
    }

    @Test
    fun languageChangeRefetchesLocalizedCatalog() = runTest {
        var systemLanguage = "en"
        val settingsStore = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { systemLanguage }, storeScope())
        val store = BillerCatalogStore(FakeBillerRepository(MockNetwork(0, 0)), settingsStore, { Instant.EPOCH }, storeScope())
        advanceUntilIdle()
        assertEquals("Electricity", store.catalog.value.valueOrNull!!.categoryById("electricity")!!.name)
        systemLanguage = "hi"
        settingsStore.refreshLanguage()
        advanceUntilIdle()
        assertEquals("बिजली", store.catalog.value.valueOrNull!!.categoryById("electricity")!!.name)
    }

    @Test
    fun refreshIfStaleOnlyRefetchesPastMaxAge() = runTest {
        var now = Instant.EPOCH
        val repository = CountingBillerRepository(FakeBillerRepository(MockNetwork(0, 0)))
        val store = BillerCatalogStore(repository, settings(), Clock { now }, storeScope())
        advanceUntilIdle()
        assertEquals(1, repository.fetchCount)
        store.refreshIfStale()
        advanceUntilIdle()
        assertEquals(1, repository.fetchCount)
        now = now.plus(Duration.ofMinutes(31))
        store.refreshIfStale()
        advanceUntilIdle()
        assertEquals(2, repository.fetchCount)
    }

    @Test
    fun billerIdsComposeCategoryAndPrefix() = runTest {
        val store = BillerCatalogStore(FakeBillerRepository(MockNetwork(0, 0)), settings(), { Instant.EPOCH }, storeScope())
        advanceUntilIdle()
        val catalog = store.catalog.value.valueOrNull!!
        val biller = catalog.billerById("electricity-national")
        assertNotNull(biller)
        assertEquals(BillerMode.Presentment, biller!!.mode)
        assertEquals(BillerMode.OpenAmount, catalog.billerById("dth-metro")!!.mode)
        assertTrue(catalog.billerById("credit-card-city")!!.inputParams.size == 2)
    }
}

class CountingBillerRepository(private val delegate: BillerRepository) : BillerRepository {
    var fetchCount = 0

    override suspend fun fetchCatalog(language: String): BillerCatalog {
        fetchCount++
        return delegate.fetchCatalog(language)
    }

    override suspend fun search(query: String, language: String): List<Biller> =
        delegate.search(query, language)
}

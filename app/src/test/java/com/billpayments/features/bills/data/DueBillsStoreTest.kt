package com.billpayments.features.bills.data

import com.billpayments.core.async.valueOrNull
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.core.time.Clock
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.FakeAuthRepository
import com.billpayments.features.auth.data.StoredSessionRepository
import com.billpayments.features.saved_billers.data.SavedBiller
import com.billpayments.features.saved_billers.data.SavedBillersStore
import com.billpayments.features.saved_billers.data.StoredSavedBillersRepository
import java.time.Duration
import java.time.Instant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Test

private fun TestScope.storeScope(): CoroutineScope =
    CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

class DueBillsStoreTest {

    private class Fixture(scope: CoroutineScope, clock: Clock) {
        val keyValueStore = InMemoryKeyValueStore()
        val bus = UiEventBus()
        val auth = AuthStore(FakeAuthRepository(MockNetwork(0, 0)), StoredSessionRepository(keyValueStore), bus, scope)
        val saved = SavedBillersStore(auth, StoredSavedBillersRepository(keyValueStore), bus, scope)
        val repository = CountingBillRepository(FakeBillRepository(MockNetwork(0, 0), clock))
        val store = DueBillsStore(auth, saved, repository, clock, scope)
    }

    private suspend fun TestScope.login(fixture: Fixture) {
        fixture.auth.sendOtp("9876543210")
        advanceUntilIdle()
        fixture.auth.verifyOtp("123456")
        advanceUntilIdle()
    }

    @Test
    fun emptySavedBillersYieldsEmptyDueBillsWithoutFetch() = runTest {
        val fixture = Fixture(storeScope()) { Instant.EPOCH }
        login(fixture)
        advanceUntilIdle()
        assertEquals(emptyList<FetchedBill>(), fixture.store.dueBills.value.valueOrNull)
        assertEquals(0, fixture.repository.dueFetchCount)
    }

    @Test
    fun savedBillerTriggersDueBillFetch() = runTest {
        val fixture = Fixture(storeScope()) { Instant.EPOCH }
        login(fixture)
        fixture.saved.save(SavedBiller("electricity-national", "12345", "Home"))
        advanceUntilIdle()
        assertEquals(1, fixture.store.dueBills.value.valueOrNull!!.size)
    }

    @Test
    fun refreshIfStaleHonorsFiveMinuteMaxAge() = runTest {
        var now = Instant.EPOCH
        val fixture = Fixture(storeScope(), Clock { now })
        login(fixture)
        fixture.saved.save(SavedBiller("electricity-national", "12345", "Home"))
        advanceUntilIdle()
        val countAfterLoad = fixture.repository.dueFetchCount
        fixture.store.refreshIfStale()
        advanceUntilIdle()
        assertEquals(countAfterLoad, fixture.repository.dueFetchCount)
        now = now.plus(Duration.ofMinutes(6))
        fixture.store.refreshIfStale()
        advanceUntilIdle()
        assertEquals(countAfterLoad + 1, fixture.repository.dueFetchCount)
    }

    @Test
    fun invalidateRefetches() = runTest {
        val fixture = Fixture(storeScope()) { Instant.EPOCH }
        login(fixture)
        fixture.saved.save(SavedBiller("electricity-national", "12345", "Home"))
        advanceUntilIdle()
        val countAfterLoad = fixture.repository.dueFetchCount
        fixture.store.invalidate()
        advanceUntilIdle()
        assertEquals(countAfterLoad + 1, fixture.repository.dueFetchCount)
    }
}

class CountingBillRepository(private val delegate: BillRepository) : BillRepository {
    var dueFetchCount = 0

    override suspend fun fetchBill(billerId: String, account: String): FetchedBill =
        delegate.fetchBill(billerId, account)

    override suspend fun fetchDueBills(saved: List<SavedBiller>): List<FetchedBill> {
        dueFetchCount++
        return delegate.fetchDueBills(saved)
    }
}

package com.billpayments.features.bills.data

import com.billpayments.core.async.Async
import com.billpayments.core.cache.Freshness
import com.billpayments.core.time.Clock
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.userIdOrNull
import com.billpayments.features.saved_billers.data.SavedBiller
import com.billpayments.features.saved_billers.data.SavedBillersStore
import java.time.Duration
import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch

@Singleton
class DueBillsStore @Inject constructor(
    authStore: AuthStore,
    private val savedBillersStore: SavedBillersStore,
    private val repository: BillRepository,
    clock: Clock,
    private val scope: CoroutineScope,
) {
    private val freshness = Freshness(clock, Duration.ofMinutes(5))
    private val _dueBills = MutableStateFlow<Async<List<FetchedBill>>>(Async.Loading)
    val dueBills: StateFlow<Async<List<FetchedBill>>> = _dueBills.asStateFlow()

    init {
        scope.launch {
            combine(
                authStore.state.map { it.userIdOrNull }.distinctUntilChanged(),
                savedBillersStore.state,
            ) { userId, saved -> if (userId == null) emptyList() else saved.items }
                .distinctUntilChanged()
                .collectLatest { fetch(it) }
        }
    }

    private suspend fun fetch(saved: List<SavedBiller>) {
        if (saved.isEmpty()) {
            _dueBills.value = Async.Data(emptyList())
            return
        }
        _dueBills.value = Async.Loading
        try {
            _dueBills.value = Async.Data(repository.fetchDueBills(saved))
            freshness.markFetched()
        } catch (e: Exception) {
            _dueBills.value = Async.Error(e)
        }
    }

    fun refreshIfStale() {
        if (_dueBills.value is Async.Loading || !freshness.isStale()) return
        invalidate()
    }

    fun invalidate() {
        scope.launch { fetch(savedBillersStore.state.value.items) }
    }
}

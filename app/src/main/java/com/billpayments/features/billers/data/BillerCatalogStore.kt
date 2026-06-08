package com.billpayments.features.billers.data

import com.billpayments.core.async.Async
import com.billpayments.core.cache.Freshness
import com.billpayments.core.time.Clock
import com.billpayments.features.settings.data.SettingsStore
import java.time.Duration
import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

@Singleton
class BillerCatalogStore @Inject constructor(
    private val repository: BillerRepository,
    private val settingsStore: SettingsStore,
    clock: Clock,
    private val scope: CoroutineScope,
) {
    private val freshness = Freshness(clock, Duration.ofMinutes(30))
    private val _catalog = MutableStateFlow<Async<BillerCatalog>>(Async.Loading)
    val catalog: StateFlow<Async<BillerCatalog>> = _catalog.asStateFlow()

    init {
        scope.launch {
            settingsStore.language.collectLatest { fetch(it) }
        }
    }

    private suspend fun fetch(language: String) {
        _catalog.value = Async.Loading
        try {
            _catalog.value = Async.Data(repository.fetchCatalog(language))
            freshness.markFetched()
        } catch (e: Exception) {
            _catalog.value = Async.Error(e)
        }
    }

    fun refreshIfStale() {
        if (_catalog.value is Async.Loading || !freshness.isStale()) return
        scope.launch { fetch(settingsStore.language.value) }
    }

    fun retry() {
        scope.launch { fetch(settingsStore.language.value) }
    }
}

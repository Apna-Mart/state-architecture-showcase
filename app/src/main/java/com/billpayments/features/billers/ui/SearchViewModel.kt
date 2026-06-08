package com.billpayments.features.billers.ui

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.core.async.Async
import com.billpayments.core.async.valueOrNull
import com.billpayments.features.billers.data.Biller
import com.billpayments.features.billers.data.BillerCatalogStore
import com.billpayments.features.billers.data.BillerRepository
import com.billpayments.features.settings.data.SettingsStore
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.stateIn

@OptIn(ExperimentalCoroutinesApi::class)
@HiltViewModel
class SearchViewModel @Inject constructor(
    private val repository: BillerRepository,
    catalogStore: BillerCatalogStore,
    settingsStore: SettingsStore,
    private val savedStateHandle: SavedStateHandle,
) : ViewModel() {

    val query: StateFlow<String> = savedStateHandle.getStateFlow(QUERY_KEY, "")

    private val results: Flow<Async<List<Biller>>> =
        combine(query, settingsStore.language, ::Pair).flatMapLatest { (value, language) ->
            flow {
                if (value.trim().length < 2) {
                    emit(Async.Data(emptyList()))
                    return@flow
                }
                emit(Async.Loading)
                delay(200)
                try {
                    emit(Async.Data(repository.search(value, language)))
                } catch (e: Exception) {
                    emit(Async.Error(e))
                }
            }
        }

    val screenData: StateFlow<SearchScreenData> =
        combine(query, results, catalogStore.catalog) { queryValue, resultsAsync, catalogAsync ->
            if (queryValue.trim().length < 2) return@combine SearchScreenData.Idle
            when (resultsAsync) {
                is Async.Data -> if (resultsAsync.value.isEmpty()) {
                    SearchScreenData.Empty(queryValue)
                } else {
                    val catalog = catalogAsync.valueOrNull
                    SearchScreenData.Results(
                        resultsAsync.value.map {
                            BillerListItemData(
                                id = it.id,
                                name = it.name,
                                categoryName = catalog?.categoryById(it.categoryId)?.name ?: "",
                            )
                        },
                    )
                }
                is Async.Error -> SearchScreenData.Error(queryValue)
                Async.Loading -> SearchScreenData.Searching
            }
        }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), SearchScreenData.Idle)

    fun editQuery(value: String) {
        savedStateHandle[QUERY_KEY] = value
    }

    private companion object {
        const val QUERY_KEY = "query"
    }
}

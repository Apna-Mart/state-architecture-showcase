package com.billpayments.features.home.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.core.async.Async
import com.billpayments.core.format.daysUntilDue
import com.billpayments.core.time.DateStream
import com.billpayments.features.billers.data.BillerCatalog
import com.billpayments.features.billers.data.BillerCatalogStore
import com.billpayments.features.billers.data.BillerMode
import com.billpayments.features.bills.data.DueBillsStore
import com.billpayments.features.bills.data.FetchedBill
import com.billpayments.features.saved_billers.data.SavedBiller
import com.billpayments.features.saved_billers.data.SavedBillersStore
import dagger.hilt.android.lifecycle.HiltViewModel
import java.time.LocalDate
import javax.inject.Inject
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn

@HiltViewModel
class HomeViewModel @Inject constructor(
    catalogStore: BillerCatalogStore,
    savedBillersStore: SavedBillersStore,
    dueBillsStore: DueBillsStore,
    dateStream: DateStream,
) : ViewModel() {

    val categories: StateFlow<HomeCategoriesData> = catalogStore.catalog
        .map(::projectCategories)
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), HomeCategoriesData.Loading)

    val savedBillers: StateFlow<HomeSavedBillersData> =
        combine(catalogStore.catalog, savedBillersStore.state) { catalog, saved ->
            projectSavedBillers(catalog, saved.items)
        }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), HomeSavedBillersData.Loading)

    val reminders: StateFlow<HomeRemindersData> =
        combine(
            catalogStore.catalog,
            dueBillsStore.dueBills,
            savedBillersStore.state,
            dateStream.dates(),
        ) { catalog, dueBills, saved, today ->
            projectReminders(catalog, dueBills, saved.items, today)
        }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), HomeRemindersData.Loading)

    private fun projectCategories(catalogAsync: Async<BillerCatalog>): HomeCategoriesData = when (catalogAsync) {
        is Async.Data -> HomeCategoriesData.Loaded(catalogAsync.value.categories.map { CategoryItemData(it.id, it.name) })
        is Async.Error -> HomeCategoriesData.Error(catalogAsync.error.toString())
        Async.Loading -> HomeCategoriesData.Loading
    }

    private fun projectSavedBillers(
        catalogAsync: Async<BillerCatalog>,
        saved: List<SavedBiller>,
    ): HomeSavedBillersData {
        if (saved.isEmpty()) return HomeSavedBillersData.Loaded(emptyList())
        val catalog = when (catalogAsync) {
            is Async.Data -> catalogAsync.value
            is Async.Error -> return HomeSavedBillersData.Loaded(emptyList())
            Async.Loading -> return HomeSavedBillersData.Loading
        }
        val byId = catalog.billers.associateBy { it.id }
        return HomeSavedBillersData.Loaded(
            saved.map {
                SavedBillerItemData(
                    billerId = it.billerId,
                    account = it.account,
                    nickname = it.nickname,
                    billerName = byId[it.billerId]?.name ?: it.billerId,
                    openAmount = byId[it.billerId]?.mode == BillerMode.OpenAmount,
                )
            },
        )
    }

    private fun projectReminders(
        catalogAsync: Async<BillerCatalog>,
        dueBillsAsync: Async<List<FetchedBill>>,
        saved: List<SavedBiller>,
        today: LocalDate,
    ): HomeRemindersData {
        if (saved.isEmpty()) return HomeRemindersData.Loaded(emptyList())
        val catalog = when (catalogAsync) {
            is Async.Data -> catalogAsync.value
            is Async.Error -> return HomeRemindersData.Loaded(emptyList())
            Async.Loading -> return HomeRemindersData.Loading
        }
        return when (dueBillsAsync) {
            is Async.Data -> HomeRemindersData.Loaded(dueItems(catalog, dueBillsAsync.value, today))
            is Async.Error -> HomeRemindersData.Loaded(emptyList())
            Async.Loading -> HomeRemindersData.Loading
        }
    }

    private fun dueItems(catalog: BillerCatalog, dueBills: List<FetchedBill>, today: LocalDate): List<DueBillItemData> {
        val byId = catalog.billers.associateBy { it.id }
        return dueBills
            .filter { byId[it.billerId]?.mode == BillerMode.Presentment }
            .map {
                DueBillItemData(
                    billerId = it.billerId,
                    account = it.account,
                    billerName = byId.getValue(it.billerId).name,
                    amountPaise = it.amountPaise,
                    dueInDays = daysUntilDue(it.dueDate, today),
                )
            }
    }
}

package com.billpayments.features.billers.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.core.async.Async
import com.billpayments.features.billers.data.BillerCatalog
import com.billpayments.features.billers.data.BillerCatalogStore
import dagger.assisted.Assisted
import dagger.assisted.AssistedFactory
import dagger.assisted.AssistedInject
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn

@HiltViewModel(assistedFactory = CategoryViewModel.Factory::class)
class CategoryViewModel @AssistedInject constructor(
    @Assisted private val categoryId: String,
    catalogStore: BillerCatalogStore,
) : ViewModel() {

    @AssistedFactory
    interface Factory {
        fun create(categoryId: String): CategoryViewModel
    }

    val screenData: StateFlow<CategoryScreenData> = catalogStore.catalog
        .map(::project)
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), CategoryScreenData.Loading)

    private fun project(catalogAsync: Async<BillerCatalog>): CategoryScreenData = when (catalogAsync) {
        is Async.Data -> {
            val category = catalogAsync.value.categoryById(categoryId)
            if (category == null) {
                CategoryScreenData.Error("Category not found")
            } else {
                CategoryScreenData.Loaded(
                    categoryName = category.name,
                    billers = catalogAsync.value.billersFor(categoryId).map {
                        BillerListItemData(it.id, it.name, category.name)
                    },
                )
            }
        }
        is Async.Error -> CategoryScreenData.Error(catalogAsync.error.toString())
        Async.Loading -> CategoryScreenData.Loading
    }
}

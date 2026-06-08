package com.billpayments.features.billers.ui

import androidx.compose.runtime.Immutable

@Immutable
sealed interface CategoryScreenData {
    data object Loading : CategoryScreenData
    data class Error(val message: String) : CategoryScreenData
    data class Loaded(val categoryName: String, val billers: List<BillerListItemData>) : CategoryScreenData
}

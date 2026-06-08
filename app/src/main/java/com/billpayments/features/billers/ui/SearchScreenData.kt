package com.billpayments.features.billers.ui

import androidx.compose.runtime.Immutable

@Immutable
sealed interface SearchScreenData {
    data object Idle : SearchScreenData
    data object Searching : SearchScreenData
    data class Empty(val query: String) : SearchScreenData
    data class Error(val query: String) : SearchScreenData
    data class Results(val billers: List<BillerListItemData>) : SearchScreenData
}

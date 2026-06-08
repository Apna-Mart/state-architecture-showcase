package com.billpayments.features.home.ui

import androidx.compose.runtime.Immutable

@Immutable
data class CategoryItemData(val id: String, val name: String)

@Immutable
data class DueBillItemData(
    val billerId: String,
    val account: String,
    val billerName: String,
    val amountPaise: Long,
    val dueInDays: Int,
)

@Immutable
data class SavedBillerItemData(
    val billerId: String,
    val account: String,
    val nickname: String,
    val billerName: String,
    val openAmount: Boolean,
)

@Immutable
sealed interface HomeRemindersData {
    data object Loading : HomeRemindersData
    data class Loaded(val items: List<DueBillItemData>) : HomeRemindersData
}

@Immutable
sealed interface HomeSavedBillersData {
    data object Loading : HomeSavedBillersData
    data class Loaded(val items: List<SavedBillerItemData>) : HomeSavedBillersData
}

@Immutable
sealed interface HomeCategoriesData {
    data object Loading : HomeCategoriesData
    data class Error(val message: String) : HomeCategoriesData
    data class Loaded(val items: List<CategoryItemData>) : HomeCategoriesData
}

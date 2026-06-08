package com.billpayments.core.nav

import androidx.navigation3.runtime.NavKey
import kotlinx.serialization.Serializable

@Serializable
sealed interface AppNavKey : NavKey

@Serializable
data object LoginKey : AppNavKey

@Serializable
data object HomeKey : AppNavKey

@Serializable
data object SearchKey : AppNavKey

@Serializable
data object HistoryKey : AppNavKey

@Serializable
data object SettingsKey : AppNavKey

@Serializable
data class CategoryKey(val categoryId: String) : AppNavKey

@Serializable
data class BillFetchKey(val billerId: String) : AppNavKey

@Serializable
data class BillReviewKey(val billerId: String, val account: String, val amountPaise: Long?) : AppNavKey

@Serializable
data class ReceiptKey(val paymentId: String) : AppNavKey

package com.billpayments.features.bills.ui

import androidx.compose.runtime.Immutable

@Immutable
sealed interface BillReviewScreenData {
    data object Loading : BillReviewScreenData
    data class Error(val message: String) : BillReviewScreenData
    data class Review(
        val billerId: String,
        val categoryId: String,
        val billerName: String,
        val account: String,
        val customerName: String?,
        val dueInDays: Int?,
        val amountPaise: Long,
        val paying: Boolean,
        val canPay: Boolean,
    ) : BillReviewScreenData
}

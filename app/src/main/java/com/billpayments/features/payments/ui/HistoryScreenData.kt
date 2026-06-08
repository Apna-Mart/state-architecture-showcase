package com.billpayments.features.payments.ui

import androidx.compose.runtime.Immutable
import com.billpayments.features.payments.data.PaymentStatus
import java.time.Instant

@Immutable
data class PaymentListItemData(
    val id: String,
    val billerName: String,
    val account: String,
    val amountPaise: Long,
    val paidAt: Instant,
    val status: PaymentStatus,
)

@Immutable
sealed interface HistoryScreenData {
    data object Empty : HistoryScreenData
    data class Loaded(val items: List<PaymentListItemData>) : HistoryScreenData
}

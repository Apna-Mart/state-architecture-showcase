package com.billpayments.features.payments.ui

import androidx.compose.runtime.Immutable
import java.time.Instant

@Immutable
sealed interface ReceiptScreenData {
    data object NotFound : ReceiptScreenData
    data class Processing(val billerName: String, val amountPaise: Long) : ReceiptScreenData
    data class Success(
        val paymentId: String,
        val billerId: String,
        val billerName: String,
        val account: String,
        val amountPaise: Long,
        val paidAt: Instant,
        val canSaveBiller: Boolean,
    ) : ReceiptScreenData
    data class Failed(
        val billerId: String,
        val billerName: String,
        val categoryId: String,
        val account: String,
        val amountPaise: Long,
    ) : ReceiptScreenData
}

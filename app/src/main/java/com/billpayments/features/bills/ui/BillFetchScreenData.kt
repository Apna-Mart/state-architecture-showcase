package com.billpayments.features.bills.ui

import androidx.compose.runtime.Immutable
import com.billpayments.core.nav.BillReviewKey

@Immutable
data class FetchFieldData(val key: String, val label: String, val hint: String, val value: String)

@Immutable
data class FetchInputsData(val fields: List<FetchFieldData>, val showAmount: Boolean, val amountText: String)

enum class FetchSubmitAction { FetchBill, ContinueToReview }

@Immutable
data class FetchSubmitData(val action: FetchSubmitAction, val reviewKey: BillReviewKey?)

@Immutable
sealed interface BillFetchScreenData {
    data object Loading : BillFetchScreenData
    data class Error(val message: String) : BillFetchScreenData
    data class Form(
        val billerName: String,
        val inputs: FetchInputsData,
        val submit: FetchSubmitData,
    ) : BillFetchScreenData
}

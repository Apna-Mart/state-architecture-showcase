package com.billpayments.features.bills.ui

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.core.async.Async
import com.billpayments.core.nav.BillReviewKey
import com.billpayments.features.billers.data.Biller
import com.billpayments.features.billers.data.BillerCatalog
import com.billpayments.features.billers.data.BillerCatalogStore
import com.billpayments.features.billers.data.BillerMode
import dagger.assisted.Assisted
import dagger.assisted.AssistedFactory
import dagger.assisted.AssistedInject
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlin.math.roundToLong
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.stateIn

data class BillFetchForm(val values: Map<String, String>, val amountText: String) {

    fun valueOf(key: String): String = values[key] ?: ""

    val amountPaise: Long?
        get() {
            val rupees = amountText.toDoubleOrNull() ?: return null
            if (rupees <= 0) return null
            return (rupees * 100).roundToLong()
        }
}

@HiltViewModel(assistedFactory = BillFetchViewModel.Factory::class)
class BillFetchViewModel @AssistedInject constructor(
    @Assisted private val billerId: String,
    catalogStore: BillerCatalogStore,
    private val savedStateHandle: SavedStateHandle,
) : ViewModel() {

    @AssistedFactory
    interface Factory {
        fun create(billerId: String): BillFetchViewModel
    }

    private val values = savedStateHandle.getStateFlow(VALUES_KEY, hashMapOf<String, String>())
    private val amountText = savedStateHandle.getStateFlow(AMOUNT_KEY, "")

    val screenData: StateFlow<BillFetchScreenData> =
        combine(catalogStore.catalog, values, amountText) { catalogAsync, fieldValues, amount ->
            project(catalogAsync, BillFetchForm(fieldValues, amount))
        }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), BillFetchScreenData.Loading)

    fun editField(key: String, value: String) {
        savedStateHandle[VALUES_KEY] = HashMap(values.value).apply { put(key, value) }
    }

    fun editAmount(value: String) {
        savedStateHandle[AMOUNT_KEY] = value
    }

    private fun project(catalogAsync: Async<BillerCatalog>, formValue: BillFetchForm): BillFetchScreenData =
        when (catalogAsync) {
            is Async.Data -> {
                val biller = catalogAsync.value.billerById(billerId)
                if (biller == null) BillFetchScreenData.Error("Biller not found") else formData(biller, formValue)
            }
            is Async.Error -> BillFetchScreenData.Error(catalogAsync.error.toString())
            Async.Loading -> BillFetchScreenData.Loading
        }

    private fun formData(biller: Biller, formValue: BillFetchForm): BillFetchScreenData.Form {
        val openAmount = biller.mode == BillerMode.OpenAmount
        val fieldsFilled = biller.inputParams.all { formValue.valueOf(it.key).trim().isNotEmpty() }
        val amountValid = !openAmount || formValue.amountPaise != null
        return BillFetchScreenData.Form(
            billerName = biller.name,
            inputs = FetchInputsData(
                fields = biller.inputParams.map { FetchFieldData(it.key, it.label, it.hint, formValue.valueOf(it.key)) },
                showAmount = openAmount,
                amountText = formValue.amountText,
            ),
            submit = FetchSubmitData(
                action = if (openAmount) FetchSubmitAction.ContinueToReview else FetchSubmitAction.FetchBill,
                reviewKey = if (fieldsFilled && amountValid) reviewKey(biller, formValue, openAmount) else null,
            ),
        )
    }

    private fun reviewKey(biller: Biller, formValue: BillFetchForm, openAmount: Boolean): BillReviewKey =
        BillReviewKey(
            billerId = biller.id,
            account = biller.inputParams.joinToString("|") { formValue.valueOf(it.key).trim() },
            amountPaise = if (openAmount) formValue.amountPaise else null,
        )

    private companion object {
        const val VALUES_KEY = "values"
        const val AMOUNT_KEY = "amount"
    }
}

package com.billpayments.features.payments.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.features.payments.data.Payments
import com.billpayments.features.payments.data.PaymentsStore
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn

@HiltViewModel
class HistoryViewModel @Inject constructor(paymentsStore: PaymentsStore) : ViewModel() {

    val screenData: StateFlow<HistoryScreenData> = paymentsStore.state
        .map(::project)
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), project(paymentsStore.state.value))

    private fun project(payments: Payments): HistoryScreenData {
        if (payments.items.isEmpty()) return HistoryScreenData.Empty
        return HistoryScreenData.Loaded(
            payments.items.reversed().map {
                PaymentListItemData(it.id, it.billerName, it.account, it.amountPaise, it.paidAtUtc, it.status)
            },
        )
    }
}

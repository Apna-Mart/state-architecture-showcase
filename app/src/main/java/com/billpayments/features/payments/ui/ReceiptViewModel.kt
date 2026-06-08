package com.billpayments.features.payments.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.features.payments.data.Payment
import com.billpayments.features.payments.data.PaymentStatus
import com.billpayments.features.payments.data.PaymentsStore
import com.billpayments.features.saved_billers.data.SavedBiller
import com.billpayments.features.saved_billers.data.SavedBillers
import com.billpayments.features.saved_billers.data.SavedBillersStore
import dagger.assisted.Assisted
import dagger.assisted.AssistedFactory
import dagger.assisted.AssistedInject
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.stateIn

@HiltViewModel(assistedFactory = ReceiptViewModel.Factory::class)
class ReceiptViewModel @AssistedInject constructor(
    @Assisted private val paymentId: String,
    private val paymentsStore: PaymentsStore,
    private val savedBillersStore: SavedBillersStore,
) : ViewModel() {

    @AssistedFactory
    interface Factory {
        fun create(paymentId: String): ReceiptViewModel
    }

    val screenData: StateFlow<ReceiptScreenData> =
        combine(paymentsStore.state, savedBillersStore.state) { payments, saved ->
            project(payments.byId(paymentId), saved)
        }.stateIn(
            viewModelScope,
            SharingStarted.WhileSubscribed(5_000),
            project(paymentsStore.state.value.byId(paymentId), savedBillersStore.state.value),
        )

    fun saveBiller(nickname: String) {
        val success = screenData.value as? ReceiptScreenData.Success ?: return
        savedBillersStore.save(SavedBiller(success.billerId, success.account, nickname))
    }

    fun retryPayment() {
        val failed = screenData.value as? ReceiptScreenData.Failed ?: return
        paymentsStore.pay(failed.billerId, failed.billerName, failed.categoryId, failed.account, failed.amountPaise)
    }

    private fun project(payment: Payment?, saved: SavedBillers): ReceiptScreenData {
        if (payment == null) return ReceiptScreenData.NotFound
        return when (payment.status) {
            PaymentStatus.Processing -> ReceiptScreenData.Processing(payment.billerName, payment.amountPaise)
            PaymentStatus.Success -> ReceiptScreenData.Success(
                paymentId = payment.id,
                billerId = payment.billerId,
                billerName = payment.billerName,
                account = payment.account,
                amountPaise = payment.amountPaise,
                paidAt = payment.paidAtUtc,
                canSaveBiller = !saved.contains(payment.billerId, payment.account),
            )
            PaymentStatus.Failed -> ReceiptScreenData.Failed(
                billerId = payment.billerId,
                billerName = payment.billerName,
                categoryId = payment.categoryId,
                account = payment.account,
                amountPaise = payment.amountPaise,
            )
        }
    }
}

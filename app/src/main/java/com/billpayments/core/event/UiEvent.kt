package com.billpayments.core.event

sealed interface UiEvent {
    data class PaymentStarted(val paymentId: String) : UiEvent
    data class PaymentFailed(val paymentId: String) : UiEvent
    data object OtpRejected : UiEvent
    data object AuthFailed : UiEvent
    data object StorageFailed : UiEvent
}

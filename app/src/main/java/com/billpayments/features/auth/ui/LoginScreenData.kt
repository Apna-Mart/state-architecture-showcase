package com.billpayments.features.auth.ui

import androidx.compose.runtime.Immutable

@Immutable
sealed interface LoginScreenData {
    data class PhoneEntry(val phone: String, val canSend: Boolean, val sending: Boolean) : LoginScreenData
    data class OtpEntry(val phone: String, val otp: String, val canVerify: Boolean, val verifying: Boolean) : LoginScreenData
}

package com.billpayments.features.auth.ui

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.features.auth.data.Auth
import com.billpayments.features.auth.data.AuthStore
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.stateIn

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val authStore: AuthStore,
    private val savedStateHandle: SavedStateHandle,
) : ViewModel() {

    private val phone = savedStateHandle.getStateFlow(PHONE_KEY, "")
    private val otp = savedStateHandle.getStateFlow(OTP_KEY, "")

    val screenData: StateFlow<LoginScreenData> =
        combine(authStore.state, phone, otp, ::project)
            .stateIn(
                viewModelScope,
                SharingStarted.WhileSubscribed(5_000),
                project(authStore.state.value, phone.value, otp.value),
            )

    fun editPhone(value: String) {
        savedStateHandle[PHONE_KEY] = value
    }

    fun editOtp(value: String) {
        savedStateHandle[OTP_KEY] = value
    }

    fun sendOtp() = authStore.sendOtp(phone.value)

    fun verifyOtp() = authStore.verifyOtp(otp.value)

    fun changeNumber() {
        savedStateHandle[OTP_KEY] = ""
        authStore.logout()
    }

    private fun project(auth: Auth, phoneInput: String, otpInput: String): LoginScreenData {
        val validPhone = phoneInput.length == 10 && phoneInput.toLongOrNull() != null
        return when (auth) {
            is Auth.Unauthenticated -> LoginScreenData.PhoneEntry(phoneInput, canSend = validPhone, sending = false)
            is Auth.SendingOtp -> LoginScreenData.PhoneEntry(phoneInput, canSend = false, sending = true)
            is Auth.OtpSent -> LoginScreenData.OtpEntry(auth.phone, otpInput, canVerify = otpInput.length == 6, verifying = false)
            is Auth.Verifying -> LoginScreenData.OtpEntry(auth.phone, otpInput, canVerify = false, verifying = true)
            is Auth.Authenticated -> LoginScreenData.PhoneEntry(phoneInput, canSend = false, sending = false)
        }
    }

    private companion object {
        const val PHONE_KEY = "phone"
        const val OTP_KEY = "otp"
    }
}

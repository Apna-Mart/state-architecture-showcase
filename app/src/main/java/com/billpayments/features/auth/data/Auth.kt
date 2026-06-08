package com.billpayments.features.auth.data

sealed interface Auth {
    data object Unauthenticated : Auth
    data class SendingOtp(val phone: String) : Auth
    data class OtpSent(val phone: String) : Auth
    data class Verifying(val phone: String) : Auth
    data class Authenticated(val userId: String, val phone: String) : Auth
}

val Auth.userIdOrNull: String? get() = (this as? Auth.Authenticated)?.userId

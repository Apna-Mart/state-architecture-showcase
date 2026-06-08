package com.billpayments.features.auth.data

import com.billpayments.core.mock.MockNetwork

class InvalidOtpException : Exception()

interface AuthRepository {
    suspend fun sendOtp(phone: String)
    suspend fun verifyOtp(phone: String, code: String): String
}

class FakeAuthRepository(private val network: MockNetwork) : AuthRepository {

    override suspend fun sendOtp(phone: String) = network.delay()

    override suspend fun verifyOtp(phone: String, code: String): String {
        network.delay()
        val isSixDigits = code.length == 6 && code.toIntOrNull() != null
        if (!isSixDigits) throw InvalidOtpException()
        return "user-$phone"
    }
}

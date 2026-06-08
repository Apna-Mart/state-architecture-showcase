package com.billpayments.features.payments.data

import com.billpayments.core.mock.MockNetwork

interface PaymentRepository {
    suspend fun pay(payment: Payment)
}

class FakePaymentRepository(private val network: MockNetwork) : PaymentRepository {

    override suspend fun pay(payment: Payment) {
        network.delay()
        network.countAndMaybeFail()
    }
}

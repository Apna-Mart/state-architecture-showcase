package com.billpayments.features.payments.data

import java.time.Instant

enum class PaymentStatus { Processing, Success, Failed }

data class Payment(
    val id: String,
    val billerId: String,
    val billerName: String,
    val categoryId: String,
    val account: String,
    val amountPaise: Long,
    val paidAtUtc: Instant,
    val status: PaymentStatus,
)

data class Payments(val items: List<Payment>, val nextId: Int) {

    fun byId(id: String): Payment? = items.firstOrNull { it.id == id }

    fun hasProcessing(billerId: String, account: String): Boolean = items.any {
        it.billerId == billerId && it.account == account && it.status == PaymentStatus.Processing
    }

    fun adding(payment: Payment): Payments = Payments(items + payment, nextId + 1)

    fun updatingStatus(id: String, status: PaymentStatus): Payments =
        copy(items = items.map { if (it.id == id) it.copy(status = status) else it })

    companion object {
        val EMPTY = Payments(emptyList(), 1)
    }
}

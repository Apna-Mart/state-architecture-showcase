package com.billpayments.features.payments.data

import com.billpayments.core.storage.KeyValueStore
import java.time.Instant
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json

interface PaymentHistoryRepository {
    fun restore(userId: String): Payments
    suspend fun persist(userId: String, value: Payments)
}

@Serializable
private data class PaymentDto(
    val id: String,
    val billerId: String,
    val billerName: String,
    val categoryId: String,
    val account: String,
    val amountPaise: Long,
    val paidAtUtc: String,
    val status: String,
)

@Serializable
private data class PaymentsDto(val nextId: Int, val items: List<PaymentDto>)

class StoredPaymentHistoryRepository(private val store: KeyValueStore) : PaymentHistoryRepository {

    override fun restore(userId: String): Payments {
        val raw = store.read(keyFor(userId)) ?: return Payments.EMPTY
        val dto = Json.decodeFromString<PaymentsDto>(raw)
        return Payments(nextId = dto.nextId, items = dto.items.map(::decode))
    }

    override suspend fun persist(userId: String, value: Payments) {
        val dto = PaymentsDto(
            nextId = value.nextId,
            items = value.items.map {
                PaymentDto(
                    it.id, it.billerId, it.billerName, it.categoryId,
                    it.account, it.amountPaise, it.paidAtUtc.toString(), it.status.name,
                )
            },
        )
        store.write(keyFor(userId), Json.encodeToString(dto))
    }

    private fun decode(dto: PaymentDto): Payment {
        val status = PaymentStatus.valueOf(dto.status)
        return Payment(
            id = dto.id,
            billerId = dto.billerId,
            billerName = dto.billerName,
            categoryId = dto.categoryId,
            account = dto.account,
            amountPaise = dto.amountPaise,
            paidAtUtc = Instant.parse(dto.paidAtUtc),
            status = if (status == PaymentStatus.Processing) PaymentStatus.Failed else status,
        )
    }

    private fun keyFor(userId: String) = "payments.$userId"
}

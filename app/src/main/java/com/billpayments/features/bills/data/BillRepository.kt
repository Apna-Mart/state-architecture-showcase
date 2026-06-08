package com.billpayments.features.bills.data

import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.time.Clock
import com.billpayments.features.saved_billers.data.SavedBiller
import java.time.ZoneId

interface BillRepository {
    suspend fun fetchBill(billerId: String, account: String): FetchedBill
    suspend fun fetchDueBills(saved: List<SavedBiller>): List<FetchedBill>
}

class FakeBillRepository(private val network: MockNetwork, private val clock: Clock) : BillRepository {

    override suspend fun fetchBill(billerId: String, account: String): FetchedBill {
        network.delay()
        return billFor(billerId, account)
    }

    override suspend fun fetchDueBills(saved: List<SavedBiller>): List<FetchedBill> {
        network.delay(6)
        return saved.map { billFor(it.billerId, it.account) }
    }

    private fun billFor(billerId: String, account: String): FetchedBill {
        val seed = seedOf(billerId, account)
        val today = clock.now().atZone(ZoneId.systemDefault()).toLocalDate()
        return FetchedBill(
            billerId = billerId,
            account = account,
            customerName = customers[seed % customers.size],
            amountPaise = (seed % 4500 + 200) * 100L,
            dueDate = today.plusDays((seed % 15 - 3).toLong()),
            billNumber = "BILL-${seed.toString(16).uppercase()}-$seed",
        )
    }

    private companion object {
        val customers = listOf("Ramesh Kumar", "Priya Sharma", "Amit Patel", "Sunita Reddy", "Vikram Singh")

        fun seedOf(billerId: String, account: String): Int = "$billerId|$account".sumOf { it.code }
    }
}

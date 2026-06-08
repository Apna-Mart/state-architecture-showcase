package com.billpayments.features.bills.data

import java.time.LocalDate

data class FetchedBill(
    val billerId: String,
    val account: String,
    val customerName: String,
    val amountPaise: Long,
    val dueDate: LocalDate,
    val billNumber: String,
)

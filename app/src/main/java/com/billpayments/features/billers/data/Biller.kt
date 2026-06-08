package com.billpayments.features.billers.data

enum class BillerMode { Presentment, OpenAmount }

data class BillerCategory(val id: String, val name: String)

data class BillerInputParam(val key: String, val label: String, val hint: String)

data class Biller(
    val id: String,
    val categoryId: String,
    val name: String,
    val mode: BillerMode,
    val inputParams: List<BillerInputParam>,
)

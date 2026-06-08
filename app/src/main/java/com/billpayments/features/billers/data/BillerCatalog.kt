package com.billpayments.features.billers.data

data class BillerCatalog(
    val categories: List<BillerCategory>,
    val billers: List<Biller>,
) {
    fun billersFor(categoryId: String): List<Biller> = billers.filter { it.categoryId == categoryId }

    fun billerById(id: String): Biller? = billers.firstOrNull { it.id == id }

    fun categoryById(id: String): BillerCategory? = categories.firstOrNull { it.id == id }
}

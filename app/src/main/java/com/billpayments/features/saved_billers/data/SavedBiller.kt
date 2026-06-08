package com.billpayments.features.saved_billers.data

data class SavedBiller(
    val billerId: String,
    val account: String,
    val nickname: String,
)

data class SavedBillers(val items: List<SavedBiller>) {

    fun contains(billerId: String, account: String): Boolean =
        items.any { it.billerId == billerId && it.account == account }

    fun adding(saved: SavedBiller): SavedBillers = SavedBillers(items + saved)

    fun removing(billerId: String, account: String): SavedBillers =
        SavedBillers(items.filterNot { it.billerId == billerId && it.account == account })

    companion object {
        val EMPTY = SavedBillers(emptyList())
    }
}

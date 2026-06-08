package com.billpayments.features.billers.data

import com.billpayments.core.mock.MockNetwork

interface BillerRepository {
    suspend fun fetchCatalog(language: String): BillerCatalog
    suspend fun search(query: String, language: String): List<Biller>
}

class FakeBillerRepository(private val network: MockNetwork) : BillerRepository {

    private val catalogs = mutableMapOf<String, BillerCatalog>()

    private fun catalogFor(language: String): BillerCatalog =
        catalogs.getOrPut(language) { buildCatalog(language) }

    override suspend fun fetchCatalog(language: String): BillerCatalog {
        network.delay()
        return catalogFor(language)
    }

    override suspend fun search(query: String, language: String): List<Biller> {
        network.delay()
        val needle = query.trim().lowercase()
        return catalogFor(language).billers.filter { it.name.lowercase().contains(needle) }
    }

    private companion object {
        val openAmountCategories = setOf("mobile-prepaid", "dth", "fastag")
        val prefixIds = listOf("national", "metro", "city", "state")

        fun buildCatalog(language: String): BillerCatalog {
            val categories = categoryNames.map { (id, names) -> BillerCategory(id, names.getValue(language)) }
            val billers = categoryNames.keys.flatMap { categoryId ->
                prefixIds.map { prefixId ->
                    Biller(
                        id = "$categoryId-$prefixId",
                        categoryId = categoryId,
                        name = billerName(prefixId, categoryId, language),
                        mode = if (categoryId in openAmountCategories) BillerMode.OpenAmount else BillerMode.Presentment,
                        inputParams = paramsFor(categoryId, language),
                    )
                }
            }
            return BillerCatalog(categories, billers)
        }

        fun paramsFor(categoryId: String, language: String): List<BillerInputParam> {
            if (categoryId == "credit-card") {
                return listOf(
                    BillerInputParam(
                        key = "card",
                        label = paramLabels.getValue("Card Number").getValue(language),
                        hint = paramHints.getValue("Last 4 digits").getValue(language),
                    ),
                    BillerInputParam(
                        key = "mobile",
                        label = paramLabels.getValue("Registered Mobile").getValue(language),
                        hint = paramHints.getValue("10-digit mobile").getValue(language),
                    ),
                )
            }
            val labelKey = when (categoryId) {
                "mobile-postpaid", "mobile-prepaid" -> "Mobile Number"
                "dth" -> "Subscriber ID"
                "fastag" -> "Vehicle Number"
                "lpg" -> "LPG ID"
                "insurance" -> "Policy Number"
                "loan-emi" -> "Loan Account Number"
                "education" -> "Student ID"
                else -> "Consumer Number"
            }
            val label = paramLabels.getValue(labelKey).getValue(language)
            return listOf(BillerInputParam(key = "account", label = label, hint = enterHint(label, language)))
        }
    }
}

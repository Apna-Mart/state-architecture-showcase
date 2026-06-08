package com.billpayments.features.home.ui

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountBalance
import androidx.compose.material.icons.filled.Bolt
import androidx.compose.material.icons.filled.CreditCard
import androidx.compose.material.icons.filled.HealthAndSafety
import androidx.compose.material.icons.filled.LocalFireDepartment
import androidx.compose.material.icons.filled.LocationCity
import androidx.compose.material.icons.filled.Phone
import androidx.compose.material.icons.filled.PropaneTank
import androidx.compose.material.icons.filled.ReceiptLong
import androidx.compose.material.icons.filled.SatelliteAlt
import androidx.compose.material.icons.filled.School
import androidx.compose.material.icons.filled.SimCard
import androidx.compose.material.icons.filled.Smartphone
import androidx.compose.material.icons.filled.Toll
import androidx.compose.material.icons.filled.WaterDrop
import androidx.compose.material.icons.filled.Wifi
import androidx.compose.ui.graphics.vector.ImageVector

fun categoryIcon(categoryId: String): ImageVector = when (categoryId) {
    "electricity" -> Icons.Filled.Bolt
    "water" -> Icons.Filled.WaterDrop
    "piped-gas" -> Icons.Filled.LocalFireDepartment
    "lpg" -> Icons.Filled.PropaneTank
    "mobile-postpaid" -> Icons.Filled.Smartphone
    "mobile-prepaid" -> Icons.Filled.SimCard
    "dth" -> Icons.Filled.SatelliteAlt
    "broadband" -> Icons.Filled.Wifi
    "landline" -> Icons.Filled.Phone
    "fastag" -> Icons.Filled.Toll
    "credit-card" -> Icons.Filled.CreditCard
    "insurance" -> Icons.Filled.HealthAndSafety
    "loan-emi" -> Icons.Filled.AccountBalance
    "education" -> Icons.Filled.School
    "municipal-tax" -> Icons.Filled.LocationCity
    else -> Icons.Filled.ReceiptLong
}

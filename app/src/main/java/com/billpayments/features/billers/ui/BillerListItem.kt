package com.billpayments.features.billers.ui

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.ListItem
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

@Composable
fun BillerListItem(data: BillerListItemData, onClick: (String) -> Unit) {
    ListItem(
        headlineContent = { Text(data.name) },
        supportingContent = { Text(data.categoryName) },
        modifier = Modifier.fillMaxWidth().clickable { onClick(data.id) },
    )
}

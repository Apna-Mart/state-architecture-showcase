package com.billpayments.features.payments.ui

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ListItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.billpayments.R
import com.billpayments.core.format.formatPaise
import com.billpayments.features.payments.data.PaymentStatus

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HistoryScreen(viewModel: HistoryViewModel, language: String, onBack: () -> Unit, onReceipt: (String) -> Unit) {
    val data by viewModel.screenData.collectAsStateWithLifecycle()
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.payment_history)) },
                navigationIcon = {
                    IconButton(onClick = onBack) { Icon(Icons.AutoMirrored.Filled.ArrowBack, null) }
                },
            )
        },
    ) { padding ->
        when (val state = data) {
            HistoryScreenData.Empty -> Box(
                modifier = Modifier.fillMaxSize().padding(padding),
                contentAlignment = Alignment.Center,
            ) { Text(stringResource(R.string.no_payments_yet)) }
            is HistoryScreenData.Loaded -> LazyColumn(modifier = Modifier.fillMaxSize().padding(padding)) {
                items(state.items, key = { it.id }) { item ->
                    ListItem(
                        headlineContent = { Text(item.billerName) },
                        supportingContent = { Text(stringResource(R.string.account_value, item.account)) },
                        trailingContent = { Text(formatPaise(item.amountPaise, language)) },
                        overlineContent = { Text(statusLabel(item.status)) },
                        modifier = Modifier.fillMaxWidth().clickable { onReceipt(item.id) },
                    )
                }
            }
        }
    }
}

@Composable
private fun statusLabel(status: PaymentStatus): String = stringResource(
    when (status) {
        PaymentStatus.Processing -> R.string.status_processing
        PaymentStatus.Success -> R.string.status_success
        PaymentStatus.Failed -> R.string.status_failed
    },
)

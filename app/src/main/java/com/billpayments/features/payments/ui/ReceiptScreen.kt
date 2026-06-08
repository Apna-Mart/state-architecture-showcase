package com.billpayments.features.payments.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.billpayments.R
import com.billpayments.core.format.formatDate
import com.billpayments.core.format.formatPaise
import java.time.ZoneId

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ReceiptScreen(viewModel: ReceiptViewModel, language: String, onDone: () -> Unit) {
    val data by viewModel.screenData.collectAsStateWithLifecycle()
    Scaffold(topBar = { TopAppBar(title = { Text(stringResource(R.string.payment)) }) }) { padding ->
        Box(modifier = Modifier.fillMaxSize().padding(padding), contentAlignment = Alignment.Center) {
            when (val state = data) {
                ReceiptScreenData.NotFound -> Text(stringResource(R.string.payment_not_found))
                is ReceiptScreenData.Processing -> ProcessingContent(state, language)
                is ReceiptScreenData.Success -> SuccessContent(state, language, viewModel::saveBiller, onDone)
                is ReceiptScreenData.Failed -> FailedContent(state, language, viewModel::retryPayment, onDone)
            }
        }
    }
}

@Composable
private fun ProcessingContent(data: ReceiptScreenData.Processing, language: String) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(16.dp)) {
        CircularProgressIndicator()
        Text(stringResource(R.string.paying_amount_to, formatPaise(data.amountPaise, language), data.billerName))
    }
}

@Composable
private fun SuccessContent(
    data: ReceiptScreenData.Success,
    language: String,
    onSaveBiller: (String) -> Unit,
    onDone: () -> Unit,
) {
    Column(
        modifier = Modifier.fillMaxSize().padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(12.dp, Alignment.CenterVertically),
    ) {
        Text(formatPaise(data.amountPaise, language), style = MaterialTheme.typography.headlineLarge)
        Text(stringResource(R.string.paid_to, data.billerName))
        Text(stringResource(R.string.receipt_number, data.paymentId))
        Text(stringResource(R.string.account_value, data.account))
        Text(
            stringResource(
                R.string.date_value,
                formatDate(data.paidAt.atZone(ZoneId.systemDefault()).toLocalDate(), language),
            ),
        )
        if (data.canSaveBiller) {
            OutlinedButton(onClick = { onSaveBiller(data.billerName) }, modifier = Modifier.fillMaxWidth()) {
                Text(stringResource(R.string.save_biller))
            }
        }
        Button(onClick = onDone, modifier = Modifier.fillMaxWidth()) { Text(stringResource(R.string.done)) }
    }
}

@Composable
private fun FailedContent(
    data: ReceiptScreenData.Failed,
    language: String,
    onRetry: () -> Unit,
    onDone: () -> Unit,
) {
    Column(
        modifier = Modifier.fillMaxSize().padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(12.dp, Alignment.CenterVertically),
    ) {
        Text(
            stringResource(R.string.payment_failed_summary, formatPaise(data.amountPaise, language), data.billerName),
            style = MaterialTheme.typography.titleMedium,
        )
        Button(onClick = onRetry, modifier = Modifier.fillMaxWidth()) { Text(stringResource(R.string.retry_payment)) }
        OutlinedButton(onClick = onDone, modifier = Modifier.fillMaxWidth()) { Text(stringResource(R.string.back_to_home)) }
    }
}

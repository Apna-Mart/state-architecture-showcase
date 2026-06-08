package com.billpayments.features.bills.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.pluralStringResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.billpayments.R
import com.billpayments.core.format.formatPaise

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BillReviewScreen(viewModel: BillReviewViewModel, language: String, onBack: () -> Unit) {
    val data by viewModel.screenData.collectAsStateWithLifecycle()
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.review_and_pay)) },
                navigationIcon = {
                    IconButton(onClick = onBack) { Icon(Icons.AutoMirrored.Filled.ArrowBack, null) }
                },
            )
        },
    ) { padding ->
        Box(modifier = Modifier.fillMaxSize().padding(padding), contentAlignment = Alignment.Center) {
            when (val state = data) {
                BillReviewScreenData.Loading -> CircularProgressIndicator()
                is BillReviewScreenData.Error -> Text(stringResource(R.string.something_went_wrong))
                is BillReviewScreenData.Review -> ReviewContent(state, language, viewModel::pay)
            }
        }
    }
}

@Composable
private fun ReviewContent(data: BillReviewScreenData.Review, language: String, onPay: () -> Unit) {
    Column(
        modifier = Modifier.fillMaxSize().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        Card(modifier = Modifier.fillMaxWidth()) {
            Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text(data.billerName, style = MaterialTheme.typography.titleLarge)
                Text(stringResource(R.string.account_value, data.account))
                data.customerName?.let { Text(stringResource(R.string.name_value, it)) }
                data.dueInDays?.let { days ->
                    Text(
                        when {
                            days == 0 -> stringResource(R.string.due_today)
                            days > 0 -> pluralStringResource(R.plurals.due_in_days, days, days)
                            else -> pluralStringResource(R.plurals.overdue_by_days, -days, -days)
                        },
                    )
                }
                Text(formatPaise(data.amountPaise, language), style = MaterialTheme.typography.headlineSmall)
            }
        }
        Button(onClick = onPay, enabled = data.canPay, modifier = Modifier.fillMaxWidth()) {
            if (data.paying) {
                CircularProgressIndicator(modifier = Modifier.padding(4.dp))
            } else {
                Text(stringResource(R.string.pay_amount, formatPaise(data.amountPaise, language)))
            }
        }
    }
}

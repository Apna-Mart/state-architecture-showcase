package com.billpayments.features.bills.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.billpayments.R
import com.billpayments.core.nav.BillReviewKey

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BillFetchScreen(viewModel: BillFetchViewModel, onBack: () -> Unit, onReview: (BillReviewKey) -> Unit) {
    val data by viewModel.screenData.collectAsStateWithLifecycle()
    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text((data as? BillFetchScreenData.Form)?.billerName ?: stringResource(R.string.bill_details))
                },
                navigationIcon = {
                    IconButton(onClick = onBack) { Icon(Icons.AutoMirrored.Filled.ArrowBack, null) }
                },
            )
        },
    ) { padding ->
        when (val state = data) {
            BillFetchScreenData.Loading -> Box(
                modifier = Modifier.fillMaxSize().padding(padding),
                contentAlignment = Alignment.Center,
            ) { CircularProgressIndicator() }
            is BillFetchScreenData.Error -> Box(
                modifier = Modifier.fillMaxSize().padding(padding),
                contentAlignment = Alignment.Center,
            ) { Text(stringResource(R.string.something_went_wrong)) }
            is BillFetchScreenData.Form -> FetchForm(
                data = state,
                onEditField = viewModel::editField,
                onEditAmount = viewModel::editAmount,
                onReview = onReview,
                modifier = Modifier.padding(padding),
            )
        }
    }
}

@Composable
private fun FetchForm(
    data: BillFetchScreenData.Form,
    onEditField: (String, String) -> Unit,
    onEditAmount: (String) -> Unit,
    onReview: (BillReviewKey) -> Unit,
    modifier: Modifier = Modifier,
) {
    Column(
        modifier = modifier.fillMaxSize().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        data.inputs.fields.forEach { field ->
            OutlinedTextField(
                value = field.value,
                onValueChange = { onEditField(field.key, it) },
                label = { Text(field.label) },
                placeholder = { Text(field.hint) },
                singleLine = true,
                modifier = Modifier.fillMaxWidth(),
            )
        }
        if (data.inputs.showAmount) {
            OutlinedTextField(
                value = data.inputs.amountText,
                onValueChange = onEditAmount,
                label = { Text(stringResource(R.string.amount_field_label)) },
                placeholder = { Text(stringResource(R.string.enter_amount)) },
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
                singleLine = true,
                modifier = Modifier.fillMaxWidth(),
            )
        }
        val reviewKey = data.submit.reviewKey
        Button(
            onClick = { reviewKey?.let(onReview) },
            enabled = reviewKey != null,
            modifier = Modifier.fillMaxWidth(),
        ) {
            Text(
                stringResource(
                    when (data.submit.action) {
                        FetchSubmitAction.FetchBill -> R.string.fetch_bill
                        FetchSubmitAction.ContinueToReview -> R.string.continue_label
                    },
                ),
            )
        }
    }
}

package com.billpayments.features.auth.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.billpayments.R

@Composable
fun LoginScreen(viewModel: LoginViewModel) {
    val data by viewModel.screenData.collectAsStateWithLifecycle()
    Column(
        modifier = Modifier.fillMaxSize().padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp, Alignment.CenterVertically),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Text(stringResource(R.string.app_title), style = MaterialTheme.typography.headlineMedium)
        when (val state = data) {
            is LoginScreenData.PhoneEntry -> PhoneEntry(state, viewModel::editPhone, viewModel::sendOtp)
            is LoginScreenData.OtpEntry -> OtpEntry(state, viewModel::editOtp, viewModel::verifyOtp, viewModel::changeNumber)
        }
    }
}

@Composable
private fun PhoneEntry(data: LoginScreenData.PhoneEntry, onPhoneChange: (String) -> Unit, onSend: () -> Unit) {
    OutlinedTextField(
        value = data.phone,
        onValueChange = onPhoneChange,
        label = { Text(stringResource(R.string.mobile_number)) },
        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Phone),
        singleLine = true,
        modifier = Modifier.fillMaxWidth(),
    )
    Button(onClick = onSend, enabled = data.canSend, modifier = Modifier.fillMaxWidth()) {
        if (data.sending) CircularProgressIndicator(modifier = Modifier.padding(4.dp)) else Text(stringResource(R.string.send_otp))
    }
}

@Composable
private fun OtpEntry(
    data: LoginScreenData.OtpEntry,
    onOtpChange: (String) -> Unit,
    onVerify: () -> Unit,
    onChangeNumber: () -> Unit,
) {
    Text(stringResource(R.string.otp_sent_to, data.phone))
    OutlinedTextField(
        value = data.otp,
        onValueChange = onOtpChange,
        label = { Text(stringResource(R.string.enter_otp)) },
        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.NumberPassword),
        singleLine = true,
        modifier = Modifier.fillMaxWidth(),
    )
    Button(onClick = onVerify, enabled = data.canVerify, modifier = Modifier.fillMaxWidth()) {
        if (data.verifying) CircularProgressIndicator(modifier = Modifier.padding(4.dp)) else Text(stringResource(R.string.verify))
    }
    TextButton(onClick = onChangeNumber) { Text(stringResource(R.string.change_number)) }
}

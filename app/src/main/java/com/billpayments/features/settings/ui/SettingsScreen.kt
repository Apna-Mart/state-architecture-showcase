package com.billpayments.features.settings.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.selection.selectable
import androidx.appcompat.app.AppCompatDelegate
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.core.os.LocaleListCompat
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.billpayments.R
import com.billpayments.features.settings.data.AppThemeMode

private val languageOptions = listOf(null to "", "en" to "English", "hi" to "हिन्दी", "ar" to "العربية")

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SettingsScreen(viewModel: SettingsViewModel, onBack: () -> Unit) {
    val settings by viewModel.settings.collectAsStateWithLifecycle()
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.settings)) },
                navigationIcon = {
                    IconButton(onClick = onBack) { Icon(Icons.AutoMirrored.Filled.ArrowBack, null) }
                },
            )
        },
    ) { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp)) {
            Text(stringResource(R.string.language), style = MaterialTheme.typography.titleLarge)
            val currentLanguage = AppCompatDelegate.getApplicationLocales()[0]?.language
            languageOptions.forEach { (code, label) ->
                OptionRow(
                    label = if (code == null) stringResource(R.string.system_default) else label,
                    selected = currentLanguage == code,
                    onSelect = { applyAppLanguage(code) },
                )
            }
            Text(
                stringResource(R.string.theme),
                style = MaterialTheme.typography.titleLarge,
                modifier = Modifier.padding(top = 16.dp),
            )
            AppThemeMode.entries.forEach { mode ->
                OptionRow(
                    label = stringResource(
                        when (mode) {
                            AppThemeMode.System -> R.string.system_default
                            AppThemeMode.Light -> R.string.theme_light
                            AppThemeMode.Dark -> R.string.theme_dark
                        },
                    ),
                    selected = settings.themeMode == mode,
                    onSelect = { viewModel.setThemeMode(mode) },
                )
            }
        }
    }
}

private fun applyAppLanguage(code: String?) {
    val locales = code?.let(LocaleListCompat::forLanguageTags) ?: LocaleListCompat.getEmptyLocaleList()
    AppCompatDelegate.setApplicationLocales(locales)
}

@Composable
private fun OptionRow(label: String, selected: Boolean, onSelect: () -> Unit) {
    ListItem(
        headlineContent = { Text(label) },
        leadingContent = { RadioButton(selected = selected, onClick = null) },
        modifier = Modifier.fillMaxWidth().selectable(selected = selected, onClick = onSelect),
    )
}

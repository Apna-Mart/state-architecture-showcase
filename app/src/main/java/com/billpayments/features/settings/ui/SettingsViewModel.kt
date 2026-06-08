package com.billpayments.features.settings.ui

import androidx.lifecycle.ViewModel
import com.billpayments.features.settings.data.AppSettings
import com.billpayments.features.settings.data.AppThemeMode
import com.billpayments.features.settings.data.SettingsStore
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject
import kotlinx.coroutines.flow.StateFlow

@HiltViewModel
class SettingsViewModel @Inject constructor(private val settingsStore: SettingsStore) : ViewModel() {

    val settings: StateFlow<AppSettings> = settingsStore.state

    fun setThemeMode(mode: AppThemeMode) = settingsStore.setThemeMode(mode)
}

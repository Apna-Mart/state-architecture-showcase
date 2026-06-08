package com.billpayments.features.settings.data

import com.billpayments.core.format.localeConfigs
import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

fun interface SystemLanguage {
    fun current(): String
}

@Singleton
class SettingsStore @Inject constructor(
    private val repository: SettingsRepository,
    private val systemLanguage: SystemLanguage,
    private val scope: CoroutineScope,
) {
    private val _state = MutableStateFlow(repository.restore())
    val state: StateFlow<AppSettings> = _state.asStateFlow()

    private val _language = MutableStateFlow(resolveLanguage())
    val language: StateFlow<String> = _language.asStateFlow()

    fun refreshLanguage() {
        _language.value = resolveLanguage()
    }

    private fun resolveLanguage(): String {
        val candidate = systemLanguage.current()
        return if (candidate in localeConfigs) candidate else "en"
    }

    fun setThemeMode(mode: AppThemeMode) {
        _state.value = _state.value.copy(themeMode = mode)
        scope.launch { repository.saveThemeMode(mode) }
    }
}

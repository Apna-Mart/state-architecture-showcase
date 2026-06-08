package com.billpayments.features.settings.data

import com.billpayments.core.storage.KeyValueStore

interface SettingsRepository {
    fun restore(): AppSettings
    suspend fun saveThemeMode(mode: AppThemeMode)
}

class StoredSettingsRepository(private val store: KeyValueStore) : SettingsRepository {

    override fun restore(): AppSettings {
        val themeName = store.read(THEME_MODE_KEY)
        val themeMode = AppThemeMode.entries.firstOrNull { it.name == themeName } ?: AppThemeMode.System
        return AppSettings(themeMode = themeMode)
    }

    override suspend fun saveThemeMode(mode: AppThemeMode) {
        store.write(THEME_MODE_KEY, mode.name)
    }

    private companion object {
        const val THEME_MODE_KEY = "settings.themeMode"
    }
}

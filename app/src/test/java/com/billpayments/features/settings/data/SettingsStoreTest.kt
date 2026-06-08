package com.billpayments.features.settings.data

import com.billpayments.core.storage.InMemoryKeyValueStore
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Test

class SettingsStoreTest {

    @Test
    fun defaultsToSystemTheme() = runTest {
        val store = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { "en" }, storeScope())
        assertEquals(AppThemeMode.System, store.state.value.themeMode)
    }

    @Test
    fun persistsAndRestoresTheme() = runTest {
        val keyValueStore = InMemoryKeyValueStore()
        val first = SettingsStore(StoredSettingsRepository(keyValueStore), { "en" }, storeScope())
        first.setThemeMode(AppThemeMode.Dark)
        advanceUntilIdle()
        val second = SettingsStore(StoredSettingsRepository(keyValueStore), { "en" }, storeScope())
        assertEquals(AppThemeMode.Dark, second.state.value.themeMode)
    }

    @Test
    fun languageFollowsSystemElseEnglish() = runTest {
        val arabicSystem = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { "ar" }, storeScope())
        assertEquals("ar", arabicSystem.language.value)
        val frenchSystem = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { "fr" }, storeScope())
        assertEquals("en", frenchSystem.language.value)
    }

    @Test
    fun refreshLanguagePicksUpLocaleChange() = runTest {
        var systemLanguage = "en"
        val store = SettingsStore(StoredSettingsRepository(InMemoryKeyValueStore()), { systemLanguage }, storeScope())
        assertEquals("en", store.language.value)
        systemLanguage = "hi"
        store.refreshLanguage()
        assertEquals("hi", store.language.value)
    }
}

private fun TestScope.storeScope(): CoroutineScope =
    CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

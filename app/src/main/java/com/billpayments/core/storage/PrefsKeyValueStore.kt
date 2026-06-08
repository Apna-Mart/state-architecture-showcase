package com.billpayments.core.storage

import android.content.SharedPreferences
import androidx.core.content.edit

class PrefsKeyValueStore(private val prefs: SharedPreferences) : KeyValueStore {
    override fun read(key: String): String? = prefs.getString(key, null)

    override suspend fun write(key: String, value: String) {
        prefs.edit { putString(key, value) }
    }

    override suspend fun remove(key: String) {
        prefs.edit { remove(key) }
    }
}

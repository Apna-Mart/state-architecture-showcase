package com.billpayments.core.storage

class InMemoryKeyValueStore(var failWrites: Boolean = false) : KeyValueStore {
    private val values = mutableMapOf<String, String>()

    override fun read(key: String): String? = values[key]

    override suspend fun write(key: String, value: String) {
        if (failWrites) throw StorageException()
        values[key] = value
    }

    override suspend fun remove(key: String) {
        values.remove(key)
    }
}

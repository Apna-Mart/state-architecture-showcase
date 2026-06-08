package com.billpayments.core.storage

interface KeyValueStore {
    fun read(key: String): String?
    suspend fun write(key: String, value: String)
    suspend fun remove(key: String)
}

class StorageException : RuntimeException("storage write failed")

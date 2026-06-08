package com.billpayments.features.auth.data

import com.billpayments.core.storage.KeyValueStore

data class Session(val userId: String, val phone: String)

interface SessionRepository {
    fun restore(): Session?
    suspend fun save(userId: String, phone: String)
    suspend fun clear()
}

class StoredSessionRepository(private val store: KeyValueStore) : SessionRepository {

    override fun restore(): Session? {
        val userId = store.read(USER_ID_KEY) ?: return null
        val phone = store.read(PHONE_KEY) ?: return null
        return Session(userId, phone)
    }

    override suspend fun save(userId: String, phone: String) {
        store.write(USER_ID_KEY, userId)
        store.write(PHONE_KEY, phone)
    }

    override suspend fun clear() {
        store.remove(USER_ID_KEY)
        store.remove(PHONE_KEY)
    }

    private companion object {
        const val USER_ID_KEY = "session.userId"
        const val PHONE_KEY = "session.phone"
    }
}

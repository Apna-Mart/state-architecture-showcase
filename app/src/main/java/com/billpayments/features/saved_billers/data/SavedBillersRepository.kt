package com.billpayments.features.saved_billers.data

import com.billpayments.core.storage.KeyValueStore
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json

interface SavedBillersRepository {
    fun restore(userId: String): SavedBillers
    suspend fun persist(userId: String, value: SavedBillers)
}

@Serializable
private data class SavedBillerDto(val billerId: String, val account: String, val nickname: String)

class StoredSavedBillersRepository(private val store: KeyValueStore) : SavedBillersRepository {

    override fun restore(userId: String): SavedBillers {
        val raw = store.read(keyFor(userId)) ?: return SavedBillers.EMPTY
        val dtos = Json.decodeFromString<List<SavedBillerDto>>(raw)
        return SavedBillers(dtos.map { SavedBiller(it.billerId, it.account, it.nickname) })
    }

    override suspend fun persist(userId: String, value: SavedBillers) {
        val dtos = value.items.map { SavedBillerDto(it.billerId, it.account, it.nickname) }
        store.write(keyFor(userId), Json.encodeToString(dtos))
    }

    private fun keyFor(userId: String) = "savedBillers.$userId"
}

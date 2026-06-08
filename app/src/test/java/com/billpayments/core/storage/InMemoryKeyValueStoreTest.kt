package com.billpayments.core.storage

import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertThrows
import org.junit.Test

class InMemoryKeyValueStoreTest {

    @Test
    fun readsBackWrittenValue() = runTest {
        val store = InMemoryKeyValueStore()
        store.write("k", "v")
        assertEquals("v", store.read("k"))
    }

    @Test
    fun readReturnsNullForMissingKey() {
        assertNull(InMemoryKeyValueStore().read("missing"))
    }

    @Test
    fun removeDeletesKey() = runTest {
        val store = InMemoryKeyValueStore()
        store.write("k", "v")
        store.remove("k")
        assertNull(store.read("k"))
    }

    @Test
    fun failWritesThrowsStorageException() {
        val store = InMemoryKeyValueStore(failWrites = true)
        assertThrows(StorageException::class.java) {
            kotlinx.coroutines.runBlocking { store.write("k", "v") }
        }
    }
}

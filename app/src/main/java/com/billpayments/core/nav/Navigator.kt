package com.billpayments.core.nav

import androidx.compose.runtime.mutableStateListOf
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.userIdOrNull
import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.serialization.json.Json

@Singleton
class Navigator(initial: AppNavKey) {

    @Inject
    constructor(authStore: AuthStore) : this(
        if (authStore.state.value.userIdOrNull != null) HomeKey else LoginKey,
    )

    val backStack = mutableStateListOf(initial)

    fun goTo(key: AppNavKey) {
        backStack.add(key)
    }

    fun back() {
        if (backStack.size > 1) backStack.removeAt(backStack.lastIndex)
    }

    fun setStack(vararg keys: AppNavKey) {
        backStack.clear()
        backStack.addAll(keys)
    }

    fun serialized(): String = Json.encodeToString(backStack.toList())

    fun restore(serialized: String) {
        val keys = runCatching { Json.decodeFromString<List<AppNavKey>>(serialized) }.getOrNull() ?: return
        if (keys.isNotEmpty()) setStack(*keys.toTypedArray())
    }
}

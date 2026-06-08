package com.billpayments.features.saved_billers.data

import com.billpayments.core.event.UiEvent
import com.billpayments.core.event.UiEventBus
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.userIdOrNull
import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch

@Singleton
class SavedBillersStore @Inject constructor(
    authStore: AuthStore,
    private val repository: SavedBillersRepository,
    private val events: UiEventBus,
    private val scope: CoroutineScope,
) {
    private var epoch = 0
    private var userId: String? = null
    private val _state = MutableStateFlow(initialState(authStore))
    val state: StateFlow<SavedBillers> = _state.asStateFlow()

    init {
        scope.launch {
            authStore.state.map { it.userIdOrNull }.distinctUntilChanged().collect { id ->
                epoch++
                userId = id
                _state.value = if (id == null) SavedBillers.EMPTY else repository.restore(id)
            }
        }
    }

    private fun initialState(authStore: AuthStore): SavedBillers {
        val id = authStore.state.value.userIdOrNull ?: return SavedBillers.EMPTY
        userId = id
        return repository.restore(id)
    }

    fun save(saved: SavedBiller) {
        if (_state.value.contains(saved.billerId, saved.account)) return
        commit(_state.value.adding(saved))
    }

    fun remove(billerId: String, account: String) {
        commit(_state.value.removing(billerId, account))
    }

    private fun commit(next: SavedBillers) {
        val id = userId ?: return
        val previous = _state.value
        val startedEpoch = epoch
        _state.value = next
        scope.launch {
            try {
                repository.persist(id, next)
            } catch (_: Exception) {
                if (startedEpoch != epoch) return@launch
                _state.value = previous
                events.emit(UiEvent.StorageFailed)
            }
        }
    }
}

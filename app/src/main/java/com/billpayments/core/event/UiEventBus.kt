package com.billpayments.core.event

import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.receiveAsFlow

@Singleton
class UiEventBus @Inject constructor() {
    private val channel = Channel<UiEvent>(Channel.BUFFERED)
    val events: Flow<UiEvent> = channel.receiveAsFlow()

    fun emit(event: UiEvent) {
        channel.trySend(event)
    }
}

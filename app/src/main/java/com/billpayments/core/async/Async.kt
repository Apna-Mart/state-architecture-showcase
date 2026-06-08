package com.billpayments.core.async

sealed interface Async<out T> {
    data object Loading : Async<Nothing>
    data class Data<out T>(val value: T) : Async<T>
    data class Error(val error: Throwable) : Async<Nothing>
}

val <T> Async<T>.valueOrNull: T? get() = (this as? Async.Data<T>)?.value

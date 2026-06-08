package com.billpayments.core.time

import java.time.Instant

fun interface Clock {
    fun now(): Instant
}

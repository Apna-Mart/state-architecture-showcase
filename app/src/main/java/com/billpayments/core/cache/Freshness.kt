package com.billpayments.core.cache

import com.billpayments.core.time.Clock
import java.time.Duration
import java.time.Instant

class Freshness(private val clock: Clock, private val maxAge: Duration) {
    private var fetchedAt: Instant? = null

    fun markFetched() {
        fetchedAt = clock.now()
    }

    fun isStale(): Boolean {
        val fetched = fetchedAt ?: return true
        return Duration.between(fetched, clock.now()) >= maxAge
    }
}

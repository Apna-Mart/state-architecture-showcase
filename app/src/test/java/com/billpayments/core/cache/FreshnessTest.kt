package com.billpayments.core.cache

import com.billpayments.core.time.Clock
import java.time.Duration
import java.time.Instant
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class FreshnessTest {

    @Test
    fun staleBeforeFirstFetch() {
        val freshness = Freshness(Clock { Instant.EPOCH }, Duration.ofMinutes(5))
        assertTrue(freshness.isStale())
    }

    @Test
    fun freshWithinMaxAge() {
        var now = Instant.EPOCH
        val freshness = Freshness(Clock { now }, Duration.ofMinutes(5))
        freshness.markFetched()
        now = now.plus(Duration.ofMinutes(4))
        assertFalse(freshness.isStale())
    }

    @Test
    fun staleAfterMaxAge() {
        var now = Instant.EPOCH
        val freshness = Freshness(Clock { now }, Duration.ofMinutes(5))
        freshness.markFetched()
        now = now.plus(Duration.ofMinutes(6))
        assertTrue(freshness.isStale())
    }
}

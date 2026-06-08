package com.billpayments.core.mock

import kotlin.math.max
import kotlin.random.Random
import kotlinx.coroutines.delay

class MockPaymentDeclined : Exception()

class MockNetwork(
    private val minDelayMs: Int = 300,
    private val maxDelayMs: Int = 800,
    private val failEvery: Int = 10,
    seed: Int = 42,
) {
    private val random = Random(seed)
    private var failCounter = 0

    fun nextDelayMs(): Int = minDelayMs + random.nextInt(max(1, maxDelayMs - minDelayMs))

    suspend fun delay(times: Int = 1) {
        delay(nextDelayMs().toLong() * times)
    }

    fun countAndMaybeFail() {
        failCounter++
        if (failCounter % failEvery == 0) throw MockPaymentDeclined()
    }
}

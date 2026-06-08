package com.billpayments.core.time

import java.time.LocalDate
import kotlinx.coroutines.flow.Flow

fun interface DateStream {
    fun dates(): Flow<LocalDate>
}

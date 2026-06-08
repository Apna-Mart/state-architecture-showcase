package com.billpayments.features.payments.data

import com.billpayments.core.event.UiEvent
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.time.Clock
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.userIdOrNull
import com.billpayments.features.bills.data.DueBillsStore
import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.drop
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch

@Singleton
class PaymentsStore @Inject constructor(
    authStore: AuthStore,
    private val paymentRepository: PaymentRepository,
    private val historyRepository: PaymentHistoryRepository,
    private val dueBillsStore: DueBillsStore,
    private val events: UiEventBus,
    private val clock: Clock,
    private val scope: CoroutineScope,
) {
    private var epoch = 0
    private var userId: String? = authStore.state.value.userIdOrNull
    private val _state = MutableStateFlow(userId?.let(historyRepository::restore) ?: Payments.EMPTY)
    val state: StateFlow<Payments> = _state.asStateFlow()

    init {
        scope.launch {
            authStore.state.map { it.userIdOrNull }.distinctUntilChanged().drop(1).collect { id ->
                epoch++
                userId = id
                _state.value = if (id == null) Payments.EMPTY else historyRepository.restore(id)
            }
        }
        scope.launch {
            _state.drop(1).collect { next ->
                val id = userId ?: return@collect
                try {
                    historyRepository.persist(id, next)
                } catch (_: Exception) {
                    events.emit(UiEvent.StorageFailed)
                }
            }
        }
    }

    fun pay(billerId: String, billerName: String, categoryId: String, account: String, amountPaise: Long) {
        if (_state.value.hasProcessing(billerId, account)) return
        val payment = Payment(
            id = "pay-${_state.value.nextId}",
            billerId = billerId,
            billerName = billerName,
            categoryId = categoryId,
            account = account,
            amountPaise = amountPaise,
            paidAtUtc = clock.now(),
            status = PaymentStatus.Processing,
        )
        _state.value = _state.value.adding(payment)
        events.emit(UiEvent.PaymentStarted(payment.id))
        val startedEpoch = epoch
        scope.launch {
            try {
                paymentRepository.pay(payment)
                if (startedEpoch != epoch) return@launch
                _state.value = _state.value.updatingStatus(payment.id, PaymentStatus.Success)
                dueBillsStore.invalidate()
            } catch (_: Exception) {
                if (startedEpoch != epoch) return@launch
                _state.value = _state.value.updatingStatus(payment.id, PaymentStatus.Failed)
                events.emit(UiEvent.PaymentFailed(payment.id))
            }
        }
    }
}

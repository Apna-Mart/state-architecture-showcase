package com.billpayments.features.auth.data

import com.billpayments.core.event.UiEvent
import com.billpayments.core.event.UiEventBus
import javax.inject.Inject
import javax.inject.Singleton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

@Singleton
class AuthStore @Inject constructor(
    private val authRepository: AuthRepository,
    private val sessionRepository: SessionRepository,
    private val events: UiEventBus,
    private val scope: CoroutineScope,
) {
    private val _state = MutableStateFlow(restore())
    val state: StateFlow<Auth> = _state.asStateFlow()

    private fun restore(): Auth {
        val session = sessionRepository.restore() ?: return Auth.Unauthenticated
        return Auth.Authenticated(session.userId, session.phone)
    }

    fun sendOtp(phone: String) {
        if (_state.value is Auth.SendingOtp || _state.value is Auth.Verifying) return
        _state.value = Auth.SendingOtp(phone)
        scope.launch {
            try {
                authRepository.sendOtp(phone)
                _state.value = Auth.OtpSent(phone)
            } catch (_: Exception) {
                _state.value = Auth.Unauthenticated
                events.emit(UiEvent.AuthFailed)
            }
        }
    }

    fun verifyOtp(code: String) {
        val current = _state.value
        if (current !is Auth.OtpSent) return
        _state.value = Auth.Verifying(current.phone)
        scope.launch {
            try {
                val userId = authRepository.verifyOtp(current.phone, code)
                _state.value = Auth.Authenticated(userId, current.phone)
                sessionRepository.save(userId, current.phone)
            } catch (_: InvalidOtpException) {
                _state.value = Auth.OtpSent(current.phone)
                events.emit(UiEvent.OtpRejected)
            } catch (_: Exception) {
                _state.value = Auth.OtpSent(current.phone)
                events.emit(UiEvent.AuthFailed)
            }
        }
    }

    fun logout() {
        scope.launch { sessionRepository.clear() }
        _state.value = Auth.Unauthenticated
    }
}

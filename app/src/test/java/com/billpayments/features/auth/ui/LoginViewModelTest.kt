package com.billpayments.features.auth.ui

import androidx.lifecycle.SavedStateHandle
import app.cash.turbine.test
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.InMemoryKeyValueStore
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.FakeAuthRepository
import com.billpayments.features.auth.data.StoredSessionRepository
import com.billpayments.testing.MainDispatcherRule
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Rule
import org.junit.Test

class LoginViewModelTest {

    @get:Rule
    val mainDispatcherRule = MainDispatcherRule()

    private fun TestScope.storeScope(): CoroutineScope =
        CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))

    private fun TestScope.auth(): AuthStore = AuthStore(
        FakeAuthRepository(MockNetwork(0, 0)),
        StoredSessionRepository(InMemoryKeyValueStore()),
        UiEventBus(),
        storeScope(),
    )

    @Test
    fun phoneEntryEnablesSendOnlyForTenDigitNumber() = runTest {
        val viewModel = LoginViewModel(auth(), SavedStateHandle())
        viewModel.screenData.test {
            assertEquals(LoginScreenData.PhoneEntry(phone = "", canSend = false, sending = false), awaitItem())
            viewModel.editPhone("98765")
            assertEquals(LoginScreenData.PhoneEntry(phone = "98765", canSend = false, sending = false), awaitItem())
            viewModel.editPhone("9876543210")
            assertEquals(LoginScreenData.PhoneEntry(phone = "9876543210", canSend = true, sending = false), awaitItem())
            viewModel.editPhone("98765432ab")
            assertEquals(LoginScreenData.PhoneEntry(phone = "98765432ab", canSend = false, sending = false), awaitItem())
        }
    }

    @Test
    fun sendOtpProjectsSendingThenOtpEntry() = runTest {
        val viewModel = LoginViewModel(auth(), SavedStateHandle())
        viewModel.editPhone("9876543210")
        viewModel.screenData.test {
            awaitItem()
            viewModel.sendOtp()
            advanceUntilIdle()
            assertEquals(
                LoginScreenData.OtpEntry(phone = "9876543210", otp = "", canVerify = false, verifying = false),
                expectMostRecentItem(),
            )
            viewModel.editOtp("123456")
            assertEquals(
                LoginScreenData.OtpEntry(phone = "9876543210", otp = "123456", canVerify = true, verifying = false),
                awaitItem(),
            )
        }
    }

    @Test
    fun changeNumberKeepsPhoneTextAndValidationConsistent() = runTest {
        val viewModel = LoginViewModel(auth(), SavedStateHandle())
        viewModel.editPhone("9876543210")
        viewModel.screenData.test {
            awaitItem()
            viewModel.sendOtp()
            advanceUntilIdle()
            viewModel.editOtp("123456")
            advanceUntilIdle()
            viewModel.changeNumber()
            advanceUntilIdle()
            assertEquals(
                LoginScreenData.PhoneEntry(phone = "9876543210", canSend = true, sending = false),
                expectMostRecentItem(),
            )
        }
    }

    @Test
    fun screenDataRestoresInputsFromSavedState() = runTest {
        val handle = SavedStateHandle(mapOf("phone" to "9876543210"))
        val viewModel = LoginViewModel(auth(), handle)
        viewModel.screenData.test {
            assertEquals(
                LoginScreenData.PhoneEntry(phone = "9876543210", canSend = true, sending = false),
                awaitItem(),
            )
        }
    }
}

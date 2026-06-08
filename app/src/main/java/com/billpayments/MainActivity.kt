package com.billpayments

import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.consumeWindowInsets
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalResources
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import androidx.lifecycle.compose.LifecycleResumeEffect
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.lifecycle.viewmodel.navigation3.rememberViewModelStoreNavEntryDecorator
import androidx.navigation3.runtime.entryProvider
import androidx.navigation3.runtime.rememberSaveableStateHolderNavEntryDecorator
import androidx.navigation3.ui.NavDisplay
import com.billpayments.core.event.UiEvent
import com.billpayments.core.event.UiEventBus
import com.billpayments.core.nav.BillFetchKey
import com.billpayments.core.nav.BillReviewKey
import com.billpayments.core.nav.CategoryKey
import com.billpayments.core.nav.HistoryKey
import com.billpayments.core.nav.HomeKey
import com.billpayments.core.nav.LoginKey
import com.billpayments.core.nav.Navigator
import com.billpayments.core.nav.ReceiptKey
import com.billpayments.core.nav.SearchKey
import com.billpayments.core.nav.SettingsKey
import com.billpayments.core.theme.BillPaymentsTheme
import com.billpayments.features.auth.data.AuthStore
import com.billpayments.features.auth.data.userIdOrNull
import com.billpayments.features.auth.ui.LoginScreen
import com.billpayments.features.billers.data.BillerCatalogStore
import com.billpayments.features.billers.ui.CategoryScreen
import com.billpayments.features.billers.ui.CategoryViewModel
import com.billpayments.features.billers.ui.SearchScreen
import com.billpayments.features.bills.data.DueBillsStore
import com.billpayments.features.bills.ui.BillFetchScreen
import com.billpayments.features.bills.ui.BillFetchViewModel
import com.billpayments.features.bills.ui.BillReviewScreen
import com.billpayments.features.bills.ui.BillReviewViewModel
import com.billpayments.features.home.ui.HomeScreen
import com.billpayments.features.payments.ui.HistoryScreen
import com.billpayments.features.payments.ui.ReceiptScreen
import com.billpayments.features.payments.ui.ReceiptViewModel
import com.billpayments.features.settings.data.SettingsStore
import com.billpayments.features.settings.ui.SettingsScreen
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    @Inject lateinit var navigator: Navigator
    @Inject lateinit var authStore: AuthStore
    @Inject lateinit var uiEventBus: UiEventBus
    @Inject lateinit var settingsStore: SettingsStore
    @Inject lateinit var catalogStore: BillerCatalogStore
    @Inject lateinit var dueBillsStore: DueBillsStore

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        settingsStore.refreshLanguage()
        savedInstanceState?.getString(NAV_STACK_KEY)?.let(navigator::restore)
        setContent {
            val settings by settingsStore.state.collectAsStateWithLifecycle()
            val language by settingsStore.language.collectAsStateWithLifecycle()

            LaunchedEffect(Unit) {
                authStore.state.map { it.userIdOrNull != null }.distinctUntilChanged().collect { authed ->
                    if (!authed) {
                        navigator.setStack(LoginKey)
                    } else if (navigator.backStack.lastOrNull() == LoginKey) {
                        navigator.setStack(HomeKey)
                    }
                }
            }

            LifecycleResumeEffect(Unit) {
                catalogStore.refreshIfStale()
                dueBillsStore.refreshIfStale()
                onPauseOrDispose { }
            }

            BillPaymentsTheme(themeMode = settings.themeMode) {
                AppRoot(language)
            }
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putString(NAV_STACK_KEY, navigator.serialized())
    }

    @Composable
    private fun AppRoot(language: String) {
        val snackbarHostState = remember { SnackbarHostState() }
        val resources = LocalResources.current

        LaunchedEffect(resources) {
            uiEventBus.events.collect { event ->
                when (event) {
                    is UiEvent.PaymentStarted -> navigator.setStack(HomeKey, ReceiptKey(event.paymentId))
                    is UiEvent.PaymentFailed -> launch { snackbarHostState.showSnackbar(resources.getString(R.string.payment_failed_retry)) }
                    UiEvent.OtpRejected -> launch { snackbarHostState.showSnackbar(resources.getString(R.string.invalid_otp_message)) }
                    UiEvent.AuthFailed -> launch { snackbarHostState.showSnackbar(resources.getString(R.string.something_went_wrong)) }
                    UiEvent.StorageFailed -> launch { snackbarHostState.showSnackbar(resources.getString(R.string.storage_failed_message)) }
                }
            }
        }

        Scaffold(snackbarHost = { SnackbarHost(snackbarHostState) }) { padding ->
            NavDisplay(
                backStack = navigator.backStack,
                onBack = { navigator.back() },
                entryDecorators = listOf(
                    rememberSaveableStateHolderNavEntryDecorator(),
                    rememberViewModelStoreNavEntryDecorator(),
                ),
                entryProvider = entryProvider {
                    entry<LoginKey> { LoginScreen(hiltViewModel()) }
                    entry<HomeKey> {
                        HomeScreen(
                            viewModel = hiltViewModel(),
                            language = language,
                            onSearch = { navigator.goTo(SearchKey) },
                            onHistory = { navigator.goTo(HistoryKey) },
                            onSettings = { navigator.goTo(SettingsKey) },
                            onCategory = { navigator.goTo(CategoryKey(it)) },
                            onBiller = { navigator.goTo(BillFetchKey(it)) },
                        )
                    }
                    entry<SearchKey> {
                        SearchScreen(
                            viewModel = hiltViewModel(),
                            onBack = { navigator.back() },
                            onBiller = { navigator.goTo(BillFetchKey(it)) },
                        )
                    }
                    entry<HistoryKey> {
                        HistoryScreen(
                            viewModel = hiltViewModel(),
                            language = language,
                            onBack = { navigator.back() },
                            onReceipt = { navigator.goTo(ReceiptKey(it)) },
                        )
                    }
                    entry<SettingsKey> {
                        SettingsScreen(viewModel = hiltViewModel(), onBack = { navigator.back() })
                    }
                    entry<CategoryKey> { key ->
                        CategoryScreen(
                            viewModel = hiltViewModel<CategoryViewModel, CategoryViewModel.Factory>(
                                creationCallback = { it.create(key.categoryId) },
                            ),
                            onBack = { navigator.back() },
                            onBiller = { navigator.goTo(BillFetchKey(it)) },
                        )
                    }
                    entry<BillFetchKey> { key ->
                        BillFetchScreen(
                            viewModel = hiltViewModel<BillFetchViewModel, BillFetchViewModel.Factory>(
                                creationCallback = { it.create(key.billerId) },
                            ),
                            onBack = { navigator.back() },
                            onReview = { navigator.goTo(it) },
                        )
                    }
                    entry<BillReviewKey> { key ->
                        BillReviewScreen(
                            viewModel = hiltViewModel<BillReviewViewModel, BillReviewViewModel.Factory>(
                                creationCallback = { it.create(key.billerId, key.account, key.amountPaise) },
                            ),
                            language = language,
                            onBack = { navigator.back() },
                        )
                    }
                    entry<ReceiptKey> { key ->
                        ReceiptScreen(
                            viewModel = hiltViewModel<ReceiptViewModel, ReceiptViewModel.Factory>(
                                creationCallback = { it.create(key.paymentId) },
                            ),
                            language = language,
                            onDone = { navigator.setStack(HomeKey) },
                        )
                    }
                },
                modifier = Modifier.padding(padding).consumeWindowInsets(padding),
            )
        }
    }

    private companion object {
        const val NAV_STACK_KEY = "nav_stack"
    }
}

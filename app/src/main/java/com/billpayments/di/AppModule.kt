package com.billpayments.di

import android.content.Context
import com.billpayments.core.mock.MockNetwork
import com.billpayments.core.storage.KeyValueStore
import com.billpayments.core.storage.PrefsKeyValueStore
import com.billpayments.core.time.Clock
import com.billpayments.core.time.DateStream
import com.billpayments.features.auth.data.AuthRepository
import com.billpayments.features.auth.data.FakeAuthRepository
import com.billpayments.features.auth.data.SessionRepository
import com.billpayments.features.auth.data.StoredSessionRepository
import com.billpayments.features.saved_billers.data.SavedBillersRepository
import com.billpayments.features.saved_billers.data.StoredSavedBillersRepository
import com.billpayments.features.billers.data.BillerRepository
import com.billpayments.features.billers.data.FakeBillerRepository
import com.billpayments.features.bills.data.BillRepository
import com.billpayments.features.bills.data.FakeBillRepository
import com.billpayments.features.payments.data.FakePaymentRepository
import com.billpayments.features.payments.data.PaymentHistoryRepository
import com.billpayments.features.payments.data.PaymentRepository
import com.billpayments.features.payments.data.StoredPaymentHistoryRepository
import com.billpayments.features.settings.data.SettingsRepository
import com.billpayments.features.settings.data.StoredSettingsRepository
import com.billpayments.features.settings.data.SystemLanguage
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import java.time.Duration
import java.time.Instant
import java.time.ZoneId
import javax.inject.Singleton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.flow

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    @Singleton
    fun provideAppScope(): CoroutineScope = CoroutineScope(SupervisorJob() + Dispatchers.Default)

    @Provides
    @Singleton
    fun provideClock(): Clock = Clock { Instant.now() }

    @Provides
    @Singleton
    fun provideDateStream(clock: Clock): DateStream = DateStream {
        flow {
            while (true) {
                val now = clock.now().atZone(ZoneId.systemDefault())
                emit(now.toLocalDate())
                delay(Duration.between(now, now.toLocalDate().plusDays(1).atStartOfDay(now.zone)).toMillis() + 1_000)
            }
        }
    }

    @Provides
    @Singleton
    fun provideMockNetwork(): MockNetwork = MockNetwork()

    @Provides
    @Singleton
    fun provideKeyValueStore(@ApplicationContext context: Context): KeyValueStore =
        PrefsKeyValueStore(context.getSharedPreferences("billpayments", Context.MODE_PRIVATE))

    @Provides
    @Singleton
    fun provideAuthRepository(network: MockNetwork): AuthRepository = FakeAuthRepository(network)

    @Provides
    @Singleton
    fun provideSessionRepository(store: KeyValueStore): SessionRepository = StoredSessionRepository(store)

    @Provides
    @Singleton
    fun provideSavedBillersRepository(store: KeyValueStore): SavedBillersRepository =
        StoredSavedBillersRepository(store)

    @Provides
    @Singleton
    fun provideSettingsRepository(store: KeyValueStore): SettingsRepository =
        StoredSettingsRepository(store)

    @Provides
    @Singleton
    fun provideSystemLanguage(): SystemLanguage =
        SystemLanguage { java.util.Locale.getDefault().language }

    @Provides
    @Singleton
    fun provideBillerRepository(network: MockNetwork): BillerRepository = FakeBillerRepository(network)

    @Provides
    @Singleton
    fun provideBillRepository(network: MockNetwork, clock: Clock): BillRepository =
        FakeBillRepository(network, clock)

    @Provides
    @Singleton
    fun providePaymentRepository(network: MockNetwork): PaymentRepository = FakePaymentRepository(network)

    @Provides
    @Singleton
    fun providePaymentHistoryRepository(store: KeyValueStore): PaymentHistoryRepository =
        StoredPaymentHistoryRepository(store)
}

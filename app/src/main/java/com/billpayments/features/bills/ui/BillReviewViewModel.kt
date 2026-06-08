package com.billpayments.features.bills.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.billpayments.core.async.Async
import com.billpayments.core.format.daysUntilDue
import com.billpayments.core.time.DateStream
import com.billpayments.features.billers.data.Biller
import com.billpayments.features.billers.data.BillerCatalog
import com.billpayments.features.billers.data.BillerCatalogStore
import com.billpayments.features.billers.data.BillerMode
import com.billpayments.features.bills.data.BillRepository
import com.billpayments.features.bills.data.FetchedBill
import com.billpayments.features.payments.data.PaymentsStore
import dagger.assisted.Assisted
import dagger.assisted.AssistedFactory
import dagger.assisted.AssistedInject
import dagger.hilt.android.lifecycle.HiltViewModel
import java.time.LocalDate
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.stateIn

@OptIn(ExperimentalCoroutinesApi::class)
@HiltViewModel(assistedFactory = BillReviewViewModel.Factory::class)
class BillReviewViewModel @AssistedInject constructor(
    @Assisted("billerId") private val billerId: String,
    @Assisted("account") private val account: String,
    @Assisted private val amountPaise: Long?,
    catalogStore: BillerCatalogStore,
    private val billRepository: BillRepository,
    private val paymentsStore: PaymentsStore,
    dateStream: DateStream,
) : ViewModel() {

    @AssistedFactory
    interface Factory {
        fun create(
            @Assisted("billerId") billerId: String,
            @Assisted("account") account: String,
            amountPaise: Long?,
        ): BillReviewViewModel
    }

    private val fetchedBill: Flow<Async<FetchedBill>> =
        catalogStore.catalog.flatMapLatest { catalogAsync ->
            flow {
                emit(Async.Loading)
                val biller = (catalogAsync as? Async.Data)?.value?.billerById(billerId)
                if (biller == null || biller.mode != BillerMode.Presentment) return@flow
                emit(
                    try {
                        Async.Data(billRepository.fetchBill(billerId, account))
                    } catch (e: Exception) {
                        Async.Error(e)
                    },
                )
            }
        }

    val screenData: StateFlow<BillReviewScreenData> =
        combine(
            catalogStore.catalog,
            fetchedBill,
            paymentsStore.state,
            dateStream.dates(),
        ) { catalogAsync, billAsync, payments, today ->
            project(catalogAsync, billAsync, payments.hasProcessing(billerId, account), today)
        }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), BillReviewScreenData.Loading)

    fun pay() {
        val review = screenData.value as? BillReviewScreenData.Review ?: return
        if (!review.canPay) return
        paymentsStore.pay(review.billerId, review.billerName, review.categoryId, review.account, review.amountPaise)
    }

    private fun project(
        catalogAsync: Async<BillerCatalog>,
        billAsync: Async<FetchedBill>,
        paying: Boolean,
        today: LocalDate,
    ): BillReviewScreenData {
        if (catalogAsync is Async.Error) return BillReviewScreenData.Error(catalogAsync.error.toString())
        val catalog = (catalogAsync as? Async.Data)?.value ?: return BillReviewScreenData.Loading
        val biller = catalog.billerById(billerId) ?: return BillReviewScreenData.Error("Biller not found")
        if (biller.mode == BillerMode.OpenAmount) {
            val amount = amountPaise ?: return BillReviewScreenData.Error("Amount missing")
            return review(biller, amount, customerName = null, dueInDays = null, paying = paying)
        }
        return when (billAsync) {
            is Async.Data -> review(
                biller,
                billAsync.value.amountPaise,
                customerName = billAsync.value.customerName,
                dueInDays = daysUntilDue(billAsync.value.dueDate, today),
                paying = paying,
            )
            is Async.Error -> BillReviewScreenData.Error(billAsync.error.toString())
            Async.Loading -> BillReviewScreenData.Loading
        }
    }

    private fun review(
        biller: Biller,
        amount: Long,
        customerName: String?,
        dueInDays: Int?,
        paying: Boolean,
    ): BillReviewScreenData.Review = BillReviewScreenData.Review(
        billerId = biller.id,
        categoryId = biller.categoryId,
        billerName = biller.name,
        account = account,
        customerName = customerName,
        dueInDays = dueInDays,
        amountPaise = amount,
        paying = paying,
        canPay = !paying,
    )
}

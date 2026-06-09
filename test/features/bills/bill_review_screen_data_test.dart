import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/billers/data/biller.dart';
import 'package:billpayments/features/billers/data/biller_catalog.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:billpayments/features/billers/data/biller_repository.dart';
import 'package:billpayments/features/bills/data/fetched_bill_provider.dart';
import 'package:billpayments/features/bills/ui/bill_review_screen_data.dart';
import 'package:billpayments/features/bills/ui/bill_review_screen_data_provider.dart';
import 'package:billpayments/features/payments/data/payments_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _ExplodingBillerRepository implements BillerRepository {
  @override
  Future<BillerCatalog> fetchCatalog(String language) async =>
      throw Exception('server down');

  @override
  Future<List<Biller>> search(String query, String language) async =>
      const [];
}

ProviderContainer instantContainer() {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider
        .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
  ]);
  addTearDown(container.dispose);
  return container;
}

Future<void> login(ProviderContainer container) async {
  final notifier = container.read(authProvider.notifier);
  await notifier.sendOtp('9876543210');
  await notifier.verifyOtp('123456');
}

void main() {
  test('presentment review loads fetched bill with formatted amount',
      () async {
    final container = instantContainer();
    await login(container);
    const params = (
      billerId: 'electricity-metro',
      account: 'K123',
      amountPaise: null
    );
    final sub =
        container.listen(billReviewScreenDataProvider(params), (_, _) {});
    expect(container.read(billReviewScreenDataProvider(params)),
        const BillReviewScreenData.loading());
    await container.read(billerCatalogProvider.future);
    await container.read(
        fetchedBillProvider((billerId: 'electricity-metro', account: 'K123'))
            .future);
    await container.pump();
    final review = container.read(billReviewScreenDataProvider(params))
        as BillReviewLoaded;
    expect(review.billerName, 'Metro Electricity');
    expect(review.customerName, isNotNull);
    expect(review.dueInDays, isNotNull);
    expect(review.amountPaise, isA<int>());
    expect(review.canPay, isTrue);
    expect(review.paying, isFalse);
    sub.close();
  });

  test('openAmount review uses the passed amount without fetching', () async {
    final container = instantContainer();
    await login(container);
    const params = (billerId: 'dth-metro', account: 'D77', amountPaise: 25000);
    final sub =
        container.listen(billReviewScreenDataProvider(params), (_, _) {});
    await container.read(billerCatalogProvider.future);
    await container.pump();
    final review = container.read(billReviewScreenDataProvider(params))
        as BillReviewLoaded;
    expect(review.amountPaise, 25000);
    expect(review.customerName, isNull);
    expect(review.dueInDays, isNull);
    sub.close();
  });

  test('catalog failure surfaces as review error, not endless loading',
      () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        mockNetworkProvider
            .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
        billerRepositoryProvider
            .overrideWithValue(_ExplodingBillerRepository()),
      ],
    );
    addTearDown(container.dispose);
    await login(container);
    const params = (
      billerId: 'electricity-metro',
      account: 'K123',
      amountPaise: null
    );
    final sub =
        container.listen(billReviewScreenDataProvider(params), (_, _) {});
    await expectLater(
        container.read(billerCatalogProvider.future), throwsException);
    await container.pump();
    expect(container.read(billReviewScreenDataProvider(params)),
        isA<BillReviewError>());
    sub.close();
  });

  test('review shows paying while a payment for this bill is processing',
      () async {
    final container = instantContainer();
    await login(container);
    const params = (billerId: 'dth-metro', account: 'D77', amountPaise: 25000);
    final sub =
        container.listen(billReviewScreenDataProvider(params), (_, _) {});
    await container.read(billerCatalogProvider.future);
    await container.pump();
    final paymentId = container.read(paymentsProvider.notifier).pay(
        billerId: 'dth-metro',
        billerName: 'Metro DTH',
        categoryId: 'dth',
        account: 'D77',
        amountPaise: 25000);
    expect(paymentId, isNotNull);
    final during = container.read(billReviewScreenDataProvider(params))
        as BillReviewLoaded;
    expect(during.paying, isTrue);
    expect(during.canPay, isFalse);
    await Future<void>.delayed(const Duration(milliseconds: 25));
    sub.close();
  });
}

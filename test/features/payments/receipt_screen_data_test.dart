import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/payments/data/payments_provider.dart';
import 'package:billpayments/features/payments/ui/receipt_screen_data.dart';
import 'package:billpayments/features/payments/ui/receipt_screen_data_provider.dart';
import 'package:billpayments/features/saved_billers/data/saved_biller.dart';
import 'package:billpayments/features/saved_billers/data/saved_billers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer containerFailingEvery(int failEvery) {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider.overrideWithValue(
        MockNetwork(minDelayMs: 0, maxDelayMs: 1, failEvery: failEvery)),
  ]);
  addTearDown(container.dispose);
  return container;
}

Future<void> login(ProviderContainer container) async {
  final notifier = container.read(authProvider.notifier);
  await notifier.sendOtp('9876543210');
  await notifier.verifyOtp('123456');
}

Future<void> payOnce(ProviderContainer container) =>
    container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);

void main() {
  test('unknown payment id projects notFound', () async {
    final container = containerFailingEvery(100);
    await login(container);
    expect(container.read(receiptScreenDataProvider('pay-99')),
        const ReceiptScreenData.notFound());
  });

  test('successful payment projects receipt offering save biller', () async {
    final container = containerFailingEvery(100);
    await login(container);
    await payOnce(container);
    final data =
        container.read(receiptScreenDataProvider('pay-1')) as ReceiptSuccess;
    expect(data.billerName, 'Metro Electricity');
    expect(data.amountPaise, 45000);
    expect(data.canSaveBiller, isTrue);
  });

  test('already saved biller hides save action', () async {
    final container = containerFailingEvery(100);
    await login(container);
    container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'electricity-metro', account: 'K123', nickname: 'Home'));
    await payOnce(container);
    final data =
        container.read(receiptScreenDataProvider('pay-1')) as ReceiptSuccess;
    expect(data.canSaveBiller, isFalse);
  });

  test('declined payment projects failed with retry fields', () async {
    final container = containerFailingEvery(1);
    await login(container);
    await payOnce(container);
    final data =
        container.read(receiptScreenDataProvider('pay-1')) as ReceiptFailed;
    expect(data.billerId, 'electricity-metro');
    expect(data.amountPaise, 45000);
  });
}

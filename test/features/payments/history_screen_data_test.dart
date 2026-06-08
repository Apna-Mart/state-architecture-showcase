import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/payments/data/payment.dart';
import 'package:billpayments/features/payments/data/payments_provider.dart';
import 'package:billpayments/features/payments/ui/history_screen_data.dart';
import 'package:billpayments/features/payments/ui/history_screen_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('history is empty before any payment and newest-first after', () async {
    final container = ProviderContainer(overrides: [
      mockNetworkProvider.overrideWithValue(
          MockNetwork(minDelayMs: 0, maxDelayMs: 1, failEvery: 2)),
    ]);
    addTearDown(container.dispose);
    final auth = container.read(authProvider.notifier);
    await auth.sendOtp('9876543210');
    await auth.verifyOtp('123456');

    expect(container.read(historyScreenDataProvider),
        const HistoryScreenData.empty());

    final payments = container.read(paymentsProvider.notifier);
    await payments.pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K1',
        amountPaise: 10000);
    await payments.pay(
        billerId: 'water-city',
        billerName: 'City Water',
        categoryId: 'water',
        account: 'W1',
        amountPaise: 20000);

    final loaded = container.read(historyScreenDataProvider) as HistoryLoaded;
    expect(loaded.items.length, 2);
    expect(loaded.items.first.billerName, 'City Water');
    expect(loaded.items.first.status, PaymentStatus.failed);
    expect(loaded.items.last.status, PaymentStatus.success);
    expect(loaded.items.first.amountPaise, 20000);
  });
}

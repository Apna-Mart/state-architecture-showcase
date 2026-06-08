import 'package:billpayments/core/event/ui_event.dart';
import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/bills/data/due_bills_provider.dart';
import 'package:billpayments/features/payments/data/payment.dart';
import 'package:billpayments/features/payments/data/payments_provider.dart';
import 'package:billpayments/features/saved_billers/data/saved_biller.dart';
import 'package:billpayments/features/saved_billers/data/saved_billers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FailingWritesStore extends InMemoryKeyValueStore {
  _FailingWritesStore(this.failingPrefix);

  final String failingPrefix;

  @override
  Future<void> write(String key, String value) {
    if (key.startsWith(failingPrefix)) throw Exception('disk full');
    return super.write(key, value);
  }
}

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

void main() {
  test('pay appends processing then marks success and emits started',
      () async {
    final container = containerFailingEvery(100);
    await login(container);
    await container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    final payments = container.read(paymentsProvider);
    expect(payments.items.length, 1);
    expect(payments.items.single.status, PaymentStatus.success);
    expect(container.read(uiEventProvider).whereType<PaymentStarted>().length,
        1);
  });

  test('pay marks payment failed and emits paymentFailed on decline',
      () async {
    final container = containerFailingEvery(1);
    await login(container);
    await container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    final payments = container.read(paymentsProvider);
    expect(payments.items.single.status, PaymentStatus.failed);
    expect(container.read(uiEventProvider).whereType<PaymentFailed>().length,
        1);
  });

  test('pay re-entry for same bill while processing is ignored', () async {
    final container = containerFailingEvery(100);
    await login(container);
    final notifier = container.read(paymentsProvider.notifier);
    final first = notifier.pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    final second = notifier.pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    await Future.wait([first, second]);
    expect(container.read(paymentsProvider).items.length, 1);
  });

  test('logout while pay is in flight discards the stale completion',
      () async {
    final container = ProviderContainer(overrides: [
      mockNetworkProvider.overrideWithValue(
          MockNetwork(minDelayMs: 5, maxDelayMs: 6, failEvery: 100)),
    ]);
    addTearDown(container.dispose);
    await login(container);
    final payFuture = container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    container.read(authProvider.notifier).logout();
    await payFuture;
    expect(container.read(paymentsProvider).items, isEmpty);
    expect(
        container.read(uiEventProvider).whereType<PaymentFailed>(), isEmpty);
  });

  test('successful pay invalidates due bills so the list refetches', () async {
    final container = containerFailingEvery(100);
    await login(container);
    await container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'electricity-metro', account: 'K123', nickname: 'Home'));
    await container.read(dueBillsProvider.future);
    var notifications = 0;
    final sub = container.listen(dueBillsProvider, (_, _) => notifications++);
    await container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    await container.read(dueBillsProvider.future);
    expect(notifications, greaterThan(0));
    sub.close();
  });

  test('persist failure keeps the payment record and emits storageFailed',
      () async {
    final container = ProviderContainer(overrides: [
      mockNetworkProvider.overrideWithValue(
          MockNetwork(minDelayMs: 0, maxDelayMs: 1, failEvery: 100)),
      keyValueStoreProvider
          .overrideWithValue(_FailingWritesStore('payments.')),
    ]);
    addTearDown(container.dispose);
    await login(container);
    await container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    await container.pump();
    expect(container.read(paymentsProvider).items.single.status,
        PaymentStatus.success);
    expect(
        container.read(uiEventProvider).whereType<StorageFailed>(), isNotEmpty);
  });

  test('logout wipes payment history', () async {
    final container = containerFailingEvery(100);
    await login(container);
    await container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);
    container.read(authProvider.notifier).logout();
    expect(container.read(paymentsProvider).items, isEmpty);
  });
}

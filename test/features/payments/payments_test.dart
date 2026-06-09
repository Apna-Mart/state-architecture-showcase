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

class _SlowFirstPaymentWriteStore extends InMemoryKeyValueStore {
  int _paymentWrites = 0;

  @override
  Future<void> write(String key, String value) async {
    if (key.startsWith('payments.')) {
      _paymentWrites++;
      if (_paymentWrites == 1) {
        await Future<void>.delayed(const Duration(milliseconds: 30));
      }
    }
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

String? payOnce(ProviderContainer container) =>
    container.read(paymentsProvider.notifier).pay(
        billerId: 'electricity-metro',
        billerName: 'Metro Electricity',
        categoryId: 'electricity',
        account: 'K123',
        amountPaise: 45000);

Future<void> settle([int milliseconds = 25]) =>
    Future<void>.delayed(Duration(milliseconds: milliseconds));

List<UiEvent> eventsOf(ProviderContainer container) =>
    [for (final q in container.read(uiEventProvider)) q.event];

void main() {
  test('pay returns the new payment id and marks success', () async {
    final container = containerFailingEvery(100);
    await login(container);
    final paymentId = payOnce(container);
    expect(paymentId, 'pay-1');
    await settle();
    final payments = container.read(paymentsProvider);
    expect(payments.items.length, 1);
    expect(payments.items.single.status, PaymentStatus.success);
    expect(eventsOf(container), isEmpty);
  });

  test('pay marks payment failed and emits paymentFailed on decline',
      () async {
    final container = containerFailingEvery(1);
    await login(container);
    payOnce(container);
    await settle();
    final payments = container.read(paymentsProvider);
    expect(payments.items.single.status, PaymentStatus.failed);
    expect(eventsOf(container).whereType<PaymentFailed>().length, 1);
  });

  test('pay re-entry for same bill while processing returns null', () async {
    final container = containerFailingEvery(100);
    await login(container);
    final firstId = payOnce(container);
    final secondId = payOnce(container);
    expect(firstId, isNotNull);
    expect(secondId, isNull);
    await settle();
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
    payOnce(container);
    container.read(authProvider.notifier).logout();
    await settle();
    expect(container.read(paymentsProvider).items, isEmpty);
    expect(eventsOf(container).whereType<PaymentFailed>(), isEmpty);
  });

  test('successful pay removes the paid bill from due list without refetch',
      () async {
    final container = containerFailingEvery(100);
    await login(container);
    await container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'electricity-metro', account: 'K123', nickname: 'Home'));
    final before = await container.read(dueBillsProvider.future);
    expect(before, hasLength(1));
    payOnce(container);
    await settle();
    final after = await container.read(dueBillsProvider.future);
    expect(after, isEmpty);
  });

  test('rapid persists land in order so storage holds the final state',
      () async {
    final store = _SlowFirstPaymentWriteStore();
    final container = ProviderContainer(overrides: [
      mockNetworkProvider.overrideWithValue(
          MockNetwork(minDelayMs: 0, maxDelayMs: 1, failEvery: 100)),
      keyValueStoreProvider.overrideWithValue(store),
    ]);
    addTearDown(container.dispose);
    await login(container);
    payOnce(container);
    await settle(80);
    expect(container.read(paymentsProvider).items.single.status,
        PaymentStatus.success);
    final stored = store.read('payments.user-9876543210')!;
    expect(stored, contains('"status":"success"'));
    expect(stored, isNot(contains('"status":"processing"')));
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
    payOnce(container);
    await settle();
    await container.pump();
    expect(container.read(paymentsProvider).items.single.status,
        PaymentStatus.success);
    expect(eventsOf(container).whereType<StorageFailed>(), isNotEmpty);
  });

  test('logout wipes payment history', () async {
    final container = containerFailingEvery(100);
    await login(container);
    payOnce(container);
    await settle();
    container.read(authProvider.notifier).logout();
    expect(container.read(paymentsProvider).items, isEmpty);
  });
}

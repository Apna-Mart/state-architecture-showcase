import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:billpayments/features/auth/data/auth.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/payments/data/payment.dart';
import 'package:billpayments/features/payments/data/payments_provider.dart';
import 'package:billpayments/features/saved_billers/data/saved_biller.dart';
import 'package:billpayments/features/saved_billers/data/saved_billers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer containerWith(KeyValueStore store) {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider
        .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
    keyValueStoreProvider.overrideWithValue(store),
  ]);
  addTearDown(container.dispose);
  return container;
}

Future<void> login(ProviderContainer container, String phone) async {
  final notifier = container.read(authProvider.notifier);
  await notifier.sendOtp(phone);
  await notifier.verifyOtp('123456');
}

Future<void> payOnce(ProviderContainer container) async {
  container.read(paymentsProvider.notifier).pay(
      billerId: 'electricity-metro',
      billerName: 'Metro Electricity',
      categoryId: 'electricity',
      account: 'K123',
      amountPaise: 45000);
  await Future<void>.delayed(const Duration(milliseconds: 25));
}

void main() {
  test('session restores authenticated state in a fresh container', () async {
    final store = InMemoryKeyValueStore();
    final first = containerWith(store);
    await login(first, '9876543210');

    final second = containerWith(store);
    expect(
      second.read(authProvider),
      const Auth.authenticated(userId: 'user-9876543210', phone: '9876543210'),
    );
  });

  test('saved billers and history restore after logout and relogin', () async {
    final store = InMemoryKeyValueStore();
    final container = containerWith(store);
    await login(container, '9876543210');
    container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'electricity-metro', account: 'K123', nickname: 'Home'));
    await payOnce(container);

    container.read(authProvider.notifier).logout();
    expect(container.read(savedBillersProvider).items, isEmpty);
    expect(container.read(paymentsProvider).items, isEmpty);

    await login(container, '9876543210');
    expect(container.read(savedBillersProvider).items.single.nickname, 'Home');
    expect(container.read(paymentsProvider).items.single.status,
        PaymentStatus.success);
  });

  test('users see only their own bucket', () async {
    final store = InMemoryKeyValueStore();
    final container = containerWith(store);
    await login(container, '9876543210');
    container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'electricity-metro', account: 'K123', nickname: 'Home'));

    container.read(authProvider.notifier).logout();
    await login(container, '1111111111');
    expect(container.read(savedBillersProvider).items, isEmpty);
  });

  test('interrupted processing payment restores as failed', () async {
    final store = InMemoryKeyValueStore();
    await store.write('payments.user-9876543210',
        '{"nextId":2,"items":[{"id":"pay-1","billerId":"electricity-metro","billerName":"Metro Electricity","categoryId":"electricity","account":"K123","amountPaise":45000,"paidAtUtc":"2026-06-05T10:00:00.000Z","status":"processing"}]}');
    await store.write('session.userId', 'user-9876543210');
    await store.write('session.phone', '9876543210');

    final container = containerWith(store);
    final payments = container.read(paymentsProvider);
    expect(payments.items.single.status, PaymentStatus.failed);
    expect(payments.nextId, 2);
  });

  test('logout keeps the on-disk session cleared across containers',
      () async {
    final store = InMemoryKeyValueStore();
    final first = containerWith(store);
    await login(first, '9876543210');
    first.read(authProvider.notifier).logout();

    final second = containerWith(store);
    expect(second.read(authProvider), const Auth.unauthenticated());
  });
}

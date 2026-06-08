import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/bills/data/due_bills_provider.dart';
import 'package:billpayments/features/bills/data/fetched_bill_provider.dart';
import 'package:billpayments/features/saved_billers/data/saved_biller.dart';
import 'package:billpayments/features/saved_billers/data/saved_billers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
  test('fetchedBill is deterministic for same biller and account', () async {
    final container = instantContainer();
    const params = (billerId: 'electricity-metro', account: 'K123');
    final sub = container.listen(fetchedBillProvider(params), (_, _) {});
    final first = await container.read(fetchedBillProvider(params).future);
    sub.close();

    final again = instantContainer();
    final sub2 = again.listen(fetchedBillProvider(params), (_, _) {});
    final second = await again.read(fetchedBillProvider(params).future);
    sub2.close();

    expect(first.amountPaise, second.amountPaise);
    expect(first.customerName, second.customerName);
    expect(first.amountPaise, greaterThanOrEqualTo(20000));
  });

  test('dueBills is empty with no saved billers', () async {
    final container = instantContainer();
    await login(container);
    final sub = container.listen(dueBillsProvider, (_, _) {});
    final bills = await container.read(dueBillsProvider.future);
    sub.close();
    expect(bills, isEmpty);
  });

  test('dueBills refetches when a biller is saved', () async {
    final container = instantContainer();
    await login(container);
    final sub = container.listen(dueBillsProvider, (_, _) {});
    await container.read(dueBillsProvider.future);
    container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'water-city', account: 'W9', nickname: 'Home Water'));
    await container.pump();
    final bills = await container.read(dueBillsProvider.future);
    sub.close();
    expect(bills.length, 1);
    expect(bills.single.billerId, 'water-city');
  });
}

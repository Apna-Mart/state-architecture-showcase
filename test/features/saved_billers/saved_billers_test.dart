import 'package:billpayments/core/event/ui_event.dart';
import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/saved_billers/data/saved_biller.dart';
import 'package:billpayments/features/saved_billers/data/saved_billers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _bescom = SavedBiller(
    billerId: 'electricity-metro', account: 'K123', nickname: 'Home Power');

class _FailingWritesStore extends InMemoryKeyValueStore {
  _FailingWritesStore(this.failingPrefix);

  final String failingPrefix;

  @override
  Future<void> write(String key, String value) {
    if (key.startsWith(failingPrefix)) throw Exception('disk full');
    return super.write(key, value);
  }
}

ProviderContainer instantContainer({KeyValueStore? store}) {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider
        .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
    if (store != null) keyValueStoreProvider.overrideWithValue(store),
  ]);
  addTearDown(container.dispose);
  return container;
}

Future<void> login(ProviderContainer container, String phone) async {
  final notifier = container.read(authProvider.notifier);
  await notifier.sendOtp(phone);
  await notifier.verifyOtp('123456');
}

void main() {
  test('save adds once and ignores duplicates', () async {
    final container = instantContainer();
    await login(container, '9876543210');
    final notifier = container.read(savedBillersProvider.notifier);
    notifier.save(_bescom);
    notifier.save(_bescom);
    expect(container.read(savedBillersProvider).items.length, 1);
  });

  test('remove deletes by billerId and account', () async {
    final container = instantContainer();
    await login(container, '9876543210');
    final notifier = container.read(savedBillersProvider.notifier);
    notifier.save(_bescom);
    notifier.remove('electricity-metro', 'K123');
    expect(container.read(savedBillersProvider).items, isEmpty);
  });

  test('persist failure rolls back the optimistic save and emits storageFailed',
      () async {
    final container =
        instantContainer(store: _FailingWritesStore('savedBillers.'));
    await login(container, '9876543210');
    await container.read(savedBillersProvider.notifier).save(_bescom);
    expect(container.read(savedBillersProvider).items, isEmpty);
    expect(container.read(uiEventProvider).map((q) => q.event),
        const [UiEvent.storageFailed()]);
  });

  test('logout wipes saved billers and relogin starts clean', () async {
    final container = instantContainer();
    await login(container, '9876543210');
    container.read(savedBillersProvider.notifier).save(_bescom);
    container.read(authProvider.notifier).logout();
    expect(container.read(savedBillersProvider).items, isEmpty);
    await login(container, '1111111111');
    expect(container.read(savedBillersProvider).items, isEmpty);
  });
}

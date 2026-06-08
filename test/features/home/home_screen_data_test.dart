import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/core/storage/key_value_store.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:billpayments/features/bills/data/due_bills_provider.dart';
import 'package:billpayments/features/home/ui/home_screen_data.dart';
import 'package:billpayments/features/home/ui/home_screen_data_provider.dart';
import 'package:billpayments/features/saved_billers/data/saved_biller.dart';
import 'package:billpayments/features/saved_billers/data/saved_billers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer instantContainer({KeyValueStore? store}) {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider
        .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
    if (store != null) keyValueStoreProvider.overrideWithValue(store),
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
  test('categories defer alone while reminders and saved resolve empty',
      () async {
    final container = instantContainer();
    await login(container);
    final sub = container.listen(homeScreenDataProvider, (_, _) {});
    expect(
      container.read(homeScreenDataProvider),
      const HomeScreenData(
        reminders: HomeRemindersData.loaded([]),
        savedBillers: HomeSavedBillersData.loaded([]),
        categories: HomeCategoriesData.loading(),
      ),
    );
    await container.read(billerCatalogProvider.future);
    await container.read(dueBillsProvider.future);
    await container.pump();
    final data = container.read(homeScreenDataProvider);
    final categories = data.categories as HomeCategoriesLoaded;
    expect(categories.items.length, 15);
    expect(data.reminders, const HomeRemindersData.loaded([]));
    expect(data.savedBillers, const HomeSavedBillersData.loaded([]));
    sub.close();
  });

  test('restored saved billers keep their sections loading until catalog',
      () async {
    final store = InMemoryKeyValueStore();
    await store.write('session.userId', 'user-9876543210');
    await store.write('session.phone', '9876543210');
    await store.write('savedBillers.user-9876543210',
        '[{"billerId":"electricity-metro","account":"K123","nickname":"Home"}]');
    final container = instantContainer(store: store);
    final sub = container.listen(homeScreenDataProvider, (_, _) {});
    final initial = container.read(homeScreenDataProvider);
    expect(initial.categories, const HomeCategoriesData.loading());
    expect(initial.reminders, const HomeRemindersData.loading());
    expect(initial.savedBillers, const HomeSavedBillersData.loading());
    await container.read(billerCatalogProvider.future);
    await container.read(dueBillsProvider.future);
    await container.pump();
    final data = container.read(homeScreenDataProvider);
    final saved = data.savedBillers as HomeSavedBillersLoaded;
    expect(saved.items.single.nickname, 'Home');
    expect(data.reminders, isA<HomeRemindersLoaded>());
    sub.close();
  });

  test('saved presentment biller appears in quick-pay and reminders',
      () async {
    final container = instantContainer();
    await login(container);
    final sub = container.listen(homeScreenDataProvider, (_, _) {});
    await container.read(billerCatalogProvider.future);
    container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'electricity-metro', account: 'K123', nickname: 'Home'));
    await container.pump();
    await container.read(dueBillsProvider.future);
    await container.pump();
    final data = container.read(homeScreenDataProvider);
    final saved = data.savedBillers as HomeSavedBillersLoaded;
    expect(saved.items.single.billerName, 'Metro Electricity');
    final reminders = data.reminders as HomeRemindersLoaded;
    expect(reminders.items.single.amountPaise, isA<int>());
    expect(reminders.items.single.dueInDays, isA<int>());
    sub.close();
  });

  test('saving a biller never notifies the categories section', () async {
    final container = instantContainer();
    await login(container);
    await container.read(billerCatalogProvider.future);
    await container.read(dueBillsProvider.future);
    var notifications = 0;
    final sub =
        container.listen(homeCategoriesProvider, (_, _) => notifications++);
    container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'electricity-metro', account: 'K123', nickname: 'Home'));
    await container.read(dueBillsProvider.future);
    await container.pump();
    expect(notifications, 0);
    sub.close();
  });

  test('saved openAmount biller is excluded from reminders', () async {
    final container = instantContainer();
    await login(container);
    final sub = container.listen(homeScreenDataProvider, (_, _) {});
    await container.read(billerCatalogProvider.future);
    container.read(savedBillersProvider.notifier).save(const SavedBiller(
        billerId: 'dth-metro', account: 'D77', nickname: 'TV'));
    await container.pump();
    await container.read(dueBillsProvider.future);
    await container.pump();
    final data = container.read(homeScreenDataProvider);
    final saved = data.savedBillers as HomeSavedBillersLoaded;
    expect(saved.items.single.openAmount, isTrue);
    expect(data.reminders, const HomeRemindersData.loaded([]));
    sub.close();
  });
}

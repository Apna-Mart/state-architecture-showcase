import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/core/time/clock.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProviderContainer containerWithClock(DateTime Function() clock) {
    final container = ProviderContainer(overrides: [
      mockNetworkProvider
          .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
      clockProvider.overrideWithValue(clock),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  test('refreshIfStale within maxAge keeps cached catalog untouched',
      () async {
    var now = DateTime(2026, 6, 5, 10);
    final container = containerWithClock(() => now);
    var notifications = 0;
    final sub =
        container.listen(billerCatalogProvider, (_, _) => notifications++);
    await container.read(billerCatalogProvider.future);
    notifications = 0;
    now = now.add(const Duration(minutes: 10));
    container.read(billerCatalogProvider.notifier).refreshIfStale();
    await container.pump();
    expect(notifications, 0);
    sub.close();
  });

  test('refreshIfStale past maxAge refetches the catalog', () async {
    var now = DateTime(2026, 6, 5, 10);
    final container = containerWithClock(() => now);
    var notifications = 0;
    final sub =
        container.listen(billerCatalogProvider, (_, _) => notifications++);
    await container.read(billerCatalogProvider.future);
    notifications = 0;
    now = now.add(const Duration(minutes: 31));
    container.read(billerCatalogProvider.notifier).refreshIfStale();
    final refreshed = await container.read(billerCatalogProvider.future);
    expect(notifications, greaterThan(0));
    expect(refreshed.categories, isNotEmpty);
    sub.close();
  });

  test('refreshIfStale before first successful fetch is a no-op', () async {
    var now = DateTime(2026, 6, 5, 10);
    final container = containerWithClock(() => now);
    final sub = container.listen(billerCatalogProvider, (_, _) {});
    container.read(billerCatalogProvider.notifier).refreshIfStale();
    final catalog = await container.read(billerCatalogProvider.future);
    expect(catalog.categories, isNotEmpty);
    sub.close();
  });
}

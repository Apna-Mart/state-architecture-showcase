import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/billers/data/biller.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:billpayments/features/billers/data/biller_search_results_provider.dart';
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

void main() {
  test('catalog loads 15 categories with 4 billers each', () async {
    final container = instantContainer();
    final sub = container.listen(billerCatalogProvider, (_, _) {});
    final catalog = await container.read(billerCatalogProvider.future);
    sub.close();
    expect(catalog.categories.length, 15);
    expect(catalog.billers.length, 60);
    expect(catalog.billersFor('electricity').length, 4);
    expect(catalog.billerById('dth-metro')!.mode, BillerMode.openAmount);
    expect(catalog.billerById('electricity-metro')!.mode,
        BillerMode.presentment);
    expect(catalog.billerById('credit-card-city')!.inputParams.length, 2);
  });

  test('search matches biller names case-insensitively after debounce',
      () async {
    final container = instantContainer();
    final sub =
        container.listen(billerSearchResultsProvider('metro elec'), (_, _) {});
    final results =
        await container.read(billerSearchResultsProvider('metro elec').future);
    sub.close();
    expect(results.length, 1);
    expect(results.single.id, 'electricity-metro');
  });

  test('search shorter than two characters returns empty without fetching',
      () async {
    final container = instantContainer();
    final sub = container.listen(billerSearchResultsProvider('m'), (_, _) {});
    final results =
        await container.read(billerSearchResultsProvider('m').future);
    sub.close();
    expect(results, isEmpty);
  });
}

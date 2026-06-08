import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/billers/data/biller.dart';
import 'package:billpayments/features/billers/data/biller_catalog.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:billpayments/features/billers/data/biller_repository.dart';
import 'package:billpayments/features/billers/data/biller_search_results_provider.dart';
import 'package:billpayments/features/billers/ui/search_query_provider.dart';
import 'package:billpayments/features/billers/ui/search_screen_data.dart';
import 'package:billpayments/features/billers/ui/search_screen_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _ExplodingBillerRepository implements BillerRepository {
  @override
  Future<BillerCatalog> fetchCatalog(String language) async =>
      const BillerCatalog(categories: [], billers: []);

  @override
  Future<List<Biller>> search(String query, String language) async =>
      throw Exception('search down');
}

void main() {
  ProviderContainer instantContainer() {
    final container = ProviderContainer(overrides: [
      mockNetworkProvider
          .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  test('short query projects idle without searching', () {
    final container = instantContainer();
    final sub = container.listen(searchScreenDataProvider, (_, _) {});
    container.read(billerSearchQueryProvider.notifier).edit('m');
    expect(container.read(searchScreenDataProvider),
        const SearchScreenData.idle());
    sub.close();
  });

  test('query projects searching then results with category names', () async {
    final container = instantContainer();
    final sub = container.listen(searchScreenDataProvider, (_, _) {});
    await container.read(billerCatalogProvider.future);
    container.read(billerSearchQueryProvider.notifier).edit('metro elec');
    expect(container.read(searchScreenDataProvider),
        const SearchScreenData.searching());
    await container.read(billerSearchResultsProvider('metro elec').future);
    await container.pump();
    final results = container.read(searchScreenDataProvider) as SearchResults;
    expect(results.billers.single.id, 'electricity-metro');
    expect(results.billers.single.categoryName, 'Electricity');
    sub.close();
  });

  test('search failure projects error with the query', () async {
    final container = ProviderContainer(
      retry: (count, error) => null,
      overrides: [
        billerRepositoryProvider
            .overrideWithValue(_ExplodingBillerRepository()),
      ],
    );
    addTearDown(container.dispose);
    final sub = container.listen(searchScreenDataProvider, (_, _) {});
    container.read(billerSearchQueryProvider.notifier).edit('metro');
    await expectLater(
        container.read(billerSearchResultsProvider('metro').future),
        throwsException);
    await container.pump();
    expect(container.read(searchScreenDataProvider),
        const SearchScreenData.error('metro'));
    sub.close();
  });

  test('no matches projects empty with the query', () async {
    final container = instantContainer();
    final sub = container.listen(searchScreenDataProvider, (_, _) {});
    container.read(billerSearchQueryProvider.notifier).edit('zzzz');
    await container.read(billerSearchResultsProvider('zzzz').future);
    await container.pump();
    expect(container.read(searchScreenDataProvider),
        const SearchScreenData.empty('zzzz'));
    sub.close();
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/biller_catalog_provider.dart';
import '../data/biller_search_results_provider.dart';
import 'biller_list_item_data.dart';
import 'search_query_provider.dart';
import 'search_screen_data.dart';

final searchScreenDataProvider = Provider.autoDispose<SearchScreenData>((ref) {
  final query = ref.watch(billerSearchQueryProvider);
  if (query.trim().length < 2) return const SearchScreenData.idle();
  final resultsAsync = ref.watch(billerSearchResultsProvider(query));
  final catalog = ref.watch(billerCatalogProvider).value;
  return switch (resultsAsync) {
    AsyncData(:final value) => value.isEmpty
        ? SearchScreenData.empty(query)
        : SearchScreenData.results(billers: [
            for (final b in value)
              BillerListItemData(
                id: b.id,
                name: b.name,
                categoryName: catalog?.categoryById(b.categoryId)?.name ?? '',
              ),
          ]),
    AsyncError() => SearchScreenData.error(query),
    _ => const SearchScreenData.searching(),
  };
});

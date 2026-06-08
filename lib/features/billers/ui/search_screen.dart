import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../data/biller_search_results_provider.dart';
import 'biller_list_item.dart';
import 'search_query_provider.dart';
import 'search_screen_data.dart';
import 'search_screen_data_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
              hintText: ref.l10n.searchBillers, border: InputBorder.none),
          onChanged: (value) =>
              ref.read(billerSearchQueryProvider.notifier).edit(value),
        ),
      ),
      body: const _SearchBody(),
    );
  }
}

class _SearchBody extends ConsumerWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(searchScreenDataProvider);
    return switch (data) {
        SearchIdle() => Center(child: Text(ref.l10n.typeAtLeastTwoCharacters)),
        SearchSearching() => const Center(child: CircularProgressIndicator()),
        SearchEmpty(:final query) =>
          Center(child: Text(ref.l10n.noBillersMatch(query))),
        SearchError(:final query) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ref.l10n.searchFailed),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(billerSearchResultsProvider(query)),
                  child: Text(ref.l10n.retry),
                ),
              ],
            ),
          ),
        SearchResults(:final billers) => ListView.builder(
            itemExtent: 72,
            itemCount: billers.length,
            itemBuilder: (context, index) =>
                BillerListItem(item: billers[index]),
          ),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../data/biller_catalog_provider.dart';
import 'biller_list_item.dart';
import 'category_screen_data.dart';
import 'category_screen_data_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(categoryScreenDataProvider(categoryId));
    return Scaffold(
      appBar: AppBar(
          title: Text(switch (data) {
        CategoryLoaded(:final categoryName) => categoryName,
        _ => ref.l10n.billers,
      })),
      body: switch (data) {
        CategoryLoading() => const Center(child: CircularProgressIndicator()),
        CategoryError() => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ref.l10n.somethingWentWrong),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => ref.invalidate(billerCatalogProvider),
                  child: Text(ref.l10n.retry),
                ),
              ],
            ),
          ),
        CategoryLoaded(:final billers) => ListView.builder(
            itemExtent: 72,
            itemCount: billers.length,
            itemBuilder: (context, index) =>
                BillerListItem(item: billers[index]),
          ),
      },
    );
  }
}

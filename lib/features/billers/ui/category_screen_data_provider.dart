import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/biller_catalog_provider.dart';
import 'biller_list_item_data.dart';
import 'category_screen_data.dart';

final categoryScreenDataProvider =
    Provider.autoDispose.family<CategoryScreenData, String>((ref, categoryId) {
  final catalogAsync = ref.watch(billerCatalogProvider);
  return switch (catalogAsync) {
    AsyncData(:final value) => () {
        final category = value.categoryById(categoryId);
        if (category == null) {
          return const CategoryScreenData.error('Category not found');
        }
        return CategoryScreenData.loaded(
          categoryName: category.name,
          billers: [
            for (final b in value.billersFor(categoryId))
              BillerListItemData(
                  id: b.id, name: b.name, categoryName: category.name),
          ],
        );
      }(),
    AsyncError(:final error) => CategoryScreenData.error('$error'),
    _ => const CategoryScreenData.loading(),
  };
});

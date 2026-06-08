import 'package:freezed_annotation/freezed_annotation.dart';

import 'biller_list_item_data.dart';

part 'category_screen_data.freezed.dart';

@freezed
sealed class CategoryScreenData with _$CategoryScreenData {
  const factory CategoryScreenData.loading() = CategoryLoading;
  const factory CategoryScreenData.error(String message) = CategoryError;
  const factory CategoryScreenData.loaded({
    required String categoryName,
    required List<BillerListItemData> billers,
  }) = CategoryLoaded;
}

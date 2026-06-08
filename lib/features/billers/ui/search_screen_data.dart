import 'package:freezed_annotation/freezed_annotation.dart';

import 'biller_list_item_data.dart';

part 'search_screen_data.freezed.dart';

@freezed
sealed class SearchScreenData with _$SearchScreenData {
  const factory SearchScreenData.idle() = SearchIdle;
  const factory SearchScreenData.searching() = SearchSearching;
  const factory SearchScreenData.empty(String query) = SearchEmpty;
  const factory SearchScreenData.error(String query) = SearchError;
  const factory SearchScreenData.results({
    required List<BillerListItemData> billers,
  }) = SearchResults;
}

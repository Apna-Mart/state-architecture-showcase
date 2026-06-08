import 'package:freezed_annotation/freezed_annotation.dart';

part 'biller_list_item_data.freezed.dart';

@freezed
abstract class BillerListItemData with _$BillerListItemData {
  const factory BillerListItemData({
    required String id,
    required String name,
    required String categoryName,
  }) = _BillerListItemData;
}

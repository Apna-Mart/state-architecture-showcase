import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/payment.dart';

part 'history_screen_data.freezed.dart';

@freezed
abstract class PaymentListItemData with _$PaymentListItemData {
  const factory PaymentListItemData({
    required String id,
    required String billerName,
    required String account,
    required int amountPaise,
    required DateTime paidAt,
    required PaymentStatus status,
  }) = _PaymentListItemData;
}

@freezed
sealed class HistoryScreenData with _$HistoryScreenData {
  const factory HistoryScreenData.empty() = HistoryEmpty;
  const factory HistoryScreenData.loaded({
    required List<PaymentListItemData> items,
  }) = HistoryLoaded;
}

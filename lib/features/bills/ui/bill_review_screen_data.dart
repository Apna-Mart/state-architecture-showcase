import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_review_screen_data.freezed.dart';

typedef ReviewParams = ({String billerId, String account, int? amountPaise});

@freezed
sealed class BillReviewScreenData with _$BillReviewScreenData {
  const factory BillReviewScreenData.loading() = BillReviewLoading;
  const factory BillReviewScreenData.error(String message) = BillReviewError;
  const factory BillReviewScreenData.review({
    required String billerId,
    required String categoryId,
    required String billerName,
    required String account,
    required String? customerName,
    required int? dueInDays,
    required int amountPaise,
    required bool paying,
    required bool canPay,
  }) = BillReviewLoaded;
}

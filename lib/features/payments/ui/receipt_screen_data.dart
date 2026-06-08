import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_screen_data.freezed.dart';

@freezed
sealed class ReceiptScreenData with _$ReceiptScreenData {
  const factory ReceiptScreenData.notFound() = ReceiptNotFound;
  const factory ReceiptScreenData.processing({
    required String billerName,
    required int amountPaise,
  }) = ReceiptProcessing;
  const factory ReceiptScreenData.success({
    required String paymentId,
    required String billerId,
    required String billerName,
    required String account,
    required int amountPaise,
    required DateTime paidAt,
    required bool canSaveBiller,
  }) = ReceiptSuccess;
  const factory ReceiptScreenData.failed({
    required String billerId,
    required String billerName,
    required String categoryId,
    required String account,
    required int amountPaise,
  }) = ReceiptFailed;
}

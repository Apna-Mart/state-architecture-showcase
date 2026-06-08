import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetched_bill.freezed.dart';

@freezed
abstract class FetchedBill with _$FetchedBill {
  const factory FetchedBill({
    required String billerId,
    required String account,
    required String customerName,
    required int amountPaise,
    required DateTime dueDate,
    required String billNumber,
  }) = _FetchedBill;
}

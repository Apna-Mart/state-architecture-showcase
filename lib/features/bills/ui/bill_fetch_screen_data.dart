import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_fetch_screen_data.freezed.dart';

@freezed
abstract class FetchFieldData with _$FetchFieldData {
  const factory FetchFieldData({
    required String key,
    required String label,
    required String hint,
  }) = _FetchFieldData;
}

@freezed
abstract class FetchInputsData with _$FetchInputsData {
  const factory FetchInputsData({
    required List<FetchFieldData> fields,
    required bool showAmount,
  }) = _FetchInputsData;
}

enum FetchSubmitAction { fetchBill, continueToReview }

@freezed
abstract class FetchSubmitData with _$FetchSubmitData {
  const factory FetchSubmitData({
    required FetchSubmitAction action,
    required String? location,
  }) = _FetchSubmitData;
}

@freezed
sealed class BillFetchScreenData with _$BillFetchScreenData {
  const factory BillFetchScreenData.loading() = BillFetchLoading;
  const factory BillFetchScreenData.error(String message) = BillFetchError;
  const factory BillFetchScreenData.form({
    required String billerName,
    required FetchInputsData inputs,
    required FetchSubmitData submit,
  }) = BillFetchFormData;
}

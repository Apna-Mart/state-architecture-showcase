import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_fetch_form.freezed.dart';

@freezed
abstract class BillFetchForm with _$BillFetchForm {
  const BillFetchForm._();

  const factory BillFetchForm({
    required Map<String, String> values,
    required String amountText,
  }) = _BillFetchForm;

  factory BillFetchForm.empty() =>
      const BillFetchForm(values: {}, amountText: '');

  String valueOf(String key) => values[key] ?? '';

  BillFetchForm setting(String key, String value) =>
      copyWith(values: {...values, key: value});

  int? get amountPaise {
    final rupees = double.tryParse(amountText);
    if (rupees == null || rupees <= 0) return null;
    return (rupees * 100).round();
  }
}

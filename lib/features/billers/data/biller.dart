import 'package:freezed_annotation/freezed_annotation.dart';

part 'biller.freezed.dart';

enum BillerMode { presentment, openAmount }

@freezed
abstract class BillerCategory with _$BillerCategory {
  const factory BillerCategory({
    required String id,
    required String name,
  }) = _BillerCategory;
}

@freezed
abstract class BillerInputParam with _$BillerInputParam {
  const factory BillerInputParam({
    required String key,
    required String label,
    required String hint,
  }) = _BillerInputParam;
}

@freezed
abstract class Biller with _$Biller {
  const factory Biller({
    required String id,
    required String categoryId,
    required String name,
    required BillerMode mode,
    required List<BillerInputParam> inputParams,
  }) = _Biller;
}

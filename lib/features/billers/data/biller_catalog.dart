import 'package:freezed_annotation/freezed_annotation.dart';

import 'biller.dart';

part 'biller_catalog.freezed.dart';

@freezed
abstract class BillerCatalog with _$BillerCatalog {
  const BillerCatalog._();

  const factory BillerCatalog({
    required List<BillerCategory> categories,
    required List<Biller> billers,
  }) = _BillerCatalog;

  List<Biller> billersFor(String categoryId) =>
      billers.where((b) => b.categoryId == categoryId).toList();

  Biller? billerById(String id) =>
      billers.where((b) => b.id == id).firstOrNull;

  BillerCategory? categoryById(String id) =>
      categories.where((c) => c.id == id).firstOrNull;
}

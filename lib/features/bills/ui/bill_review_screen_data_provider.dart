import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/format/formats.dart';
import '../../../core/time/clock.dart';
import '../../billers/data/biller.dart';
import '../../billers/data/biller_catalog_provider.dart';
import '../../payments/data/payments_provider.dart';
import '../data/fetched_bill_provider.dart';
import 'bill_review_screen_data.dart';

final billReviewScreenDataProvider = Provider.autoDispose
    .family<BillReviewScreenData, ReviewParams>((ref, params) {
  final catalogAsync = ref.watch(billerCatalogProvider);
  if (catalogAsync case AsyncError(:final error)) {
    return BillReviewScreenData.error('$error');
  }
  final catalog = catalogAsync.value;
  if (catalog == null) return const BillReviewScreenData.loading();
  final biller = catalog.billerById(params.billerId);
  if (biller == null) {
    return const BillReviewScreenData.error('Biller not found');
  }
  final paying = ref.watch(paymentsProvider
      .select((p) => p.hasProcessing(params.billerId, params.account)));

  if (biller.mode == BillerMode.openAmount) {
    final amountPaise = params.amountPaise;
    if (amountPaise == null) {
      return const BillReviewScreenData.error('Amount missing');
    }
    return _review(biller, params.account, amountPaise, null, null, paying);
  }

  final billAsync = ref.watch(fetchedBillProvider(
      (billerId: params.billerId, account: params.account)));
  return switch (billAsync) {
    AsyncData(:final value) => _review(
        biller,
        params.account,
        value.amountPaise,
        value.customerName,
        daysUntilDue(value.dueDate, ref.read(clockProvider)()),
        paying),
    AsyncError(:final error) => BillReviewScreenData.error('$error'),
    _ => const BillReviewScreenData.loading(),
  };
});

BillReviewScreenData _review(Biller biller, String account, int amountPaise,
    String? customerName, int? dueInDays, bool paying) {
  return BillReviewScreenData.review(
    billerId: biller.id,
    categoryId: biller.categoryId,
    billerName: biller.name,
    account: account,
    customerName: customerName,
    dueInDays: dueInDays,
    amountPaise: amountPaise,
    paying: paying,
    canPay: !paying,
  );
}

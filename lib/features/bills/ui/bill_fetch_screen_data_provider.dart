import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../billers/data/biller.dart';
import '../../billers/data/biller_catalog_provider.dart';
import 'bill_fetch_form.dart';
import 'bill_fetch_form_provider.dart';
import 'bill_fetch_screen_data.dart';

final billFetchScreenDataProvider = Provider.autoDispose
    .family<BillFetchScreenData, String>((ref, billerId) {
  final catalogAsync = ref.watch(billerCatalogProvider);
  final form = ref.watch(billFetchFormProvider);
  return switch (catalogAsync) {
    AsyncData(:final value) => () {
        final biller = value.billerById(billerId);
        if (biller == null) {
          return const BillFetchScreenData.error('Biller not found');
        }
        return _form(biller, form);
      }(),
    AsyncError(:final error) => BillFetchScreenData.error('$error'),
    _ => const BillFetchScreenData.loading(),
  };
});

BillFetchScreenData _form(Biller biller, BillFetchForm form) {
  final openAmount = biller.mode == BillerMode.openAmount;
  final fieldsFilled =
      biller.inputParams.every((p) => form.valueOf(p.key).trim().isNotEmpty);
  final amountValid = !openAmount || form.amountPaise != null;
  return BillFetchScreenData.form(
    billerName: biller.name,
    inputs: FetchInputsData(
      fields: [
        for (final p in biller.inputParams)
          FetchFieldData(key: p.key, label: p.label, hint: p.hint),
      ],
      showAmount: openAmount,
    ),
    submit: FetchSubmitData(
      action: openAmount
          ? FetchSubmitAction.continueToReview
          : FetchSubmitAction.fetchBill,
      location: fieldsFilled && amountValid
          ? _reviewLocation(biller, form, openAmount)
          : null,
    ),
  );
}

String _reviewLocation(Biller biller, BillFetchForm form, bool openAmount) {
  final account = Uri.encodeQueryComponent(
      biller.inputParams.map((p) => form.valueOf(p.key).trim()).join('|'));
  final amount = openAmount ? '&amount=${form.amountPaise}' : '';
  return '/biller/${biller.id}/review?account=$account$amount';
}

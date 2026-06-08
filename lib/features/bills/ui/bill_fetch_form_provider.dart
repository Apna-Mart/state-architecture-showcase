import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bill_fetch_form.dart';

final billFetchFormProvider =
    NotifierProvider.autoDispose<BillFetchFormNotifier, BillFetchForm>(
        BillFetchFormNotifier.new);

class BillFetchFormNotifier extends Notifier<BillFetchForm> {
  @override
  BillFetchForm build() => BillFetchForm.empty();

  void editField(String key, String value) => state = state.setting(key, value);

  void editAmount(String value) => state = state.copyWith(amountText: value);
}

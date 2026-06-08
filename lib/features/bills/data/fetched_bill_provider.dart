import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bill_repository.dart';
import 'fetched_bill.dart';

typedef BillParams = ({String billerId, String account});

final fetchedBillProvider = AsyncNotifierProvider.autoDispose
    .family<FetchedBillNotifier, FetchedBill, BillParams>(
        FetchedBillNotifier.new);

class FetchedBillNotifier extends AsyncNotifier<FetchedBill> {
  FetchedBillNotifier(this.params);

  final BillParams params;

  @override
  Future<FetchedBill> build() => ref
      .read(billRepositoryProvider)
      .fetchBill(params.billerId, params.account);
}

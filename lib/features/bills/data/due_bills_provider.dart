import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/stale_while_revalidate.dart';
import '../../auth/data/auth_provider.dart';
import '../../saved_billers/data/saved_billers_provider.dart';
import 'bill_repository.dart';
import 'fetched_bill.dart';

final dueBillsProvider =
    AsyncNotifierProvider<DueBillsNotifier, List<FetchedBill>>(
        DueBillsNotifier.new);

class DueBillsNotifier extends AsyncNotifier<List<FetchedBill>>
    with StaleWhileRevalidate<List<FetchedBill>> {
  @override
  Duration get maxAge => const Duration(minutes: 5);

  @override
  Future<List<FetchedBill>> build() async {
    ref.watch(authProvider.select((a) => a.userIdOrNull));
    ref.watch(savedBillersProvider.select((s) => s.accountsKey));
    final saved = ref.read(savedBillersProvider).items;
    if (saved.isEmpty) return const [];
    final bills =
        await ref.read(billRepositoryProvider).fetchDueBills(saved);
    markFetched();
    return bills;
  }

  void removePaid(String billerId, String account) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData([
      for (final bill in current)
        if (!(bill.billerId == billerId && bill.account == account)) bill,
    ]);
  }
}

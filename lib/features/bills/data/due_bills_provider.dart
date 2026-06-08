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
    final saved = ref.watch(savedBillersProvider);
    if (saved.items.isEmpty) return const [];
    final bills =
        await ref.read(billRepositoryProvider).fetchDueBills(saved.items);
    markFetched();
    return bills;
  }
}

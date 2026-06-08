import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/payments_provider.dart';
import 'history_screen_data.dart';

final historyScreenDataProvider =
    Provider.autoDispose<HistoryScreenData>((ref) {
  final payments = ref.watch(paymentsProvider);
  if (payments.items.isEmpty) return const HistoryScreenData.empty();
  return HistoryScreenData.loaded(items: [
    for (final p in payments.items.reversed)
      PaymentListItemData(
        id: p.id,
        billerName: p.billerName,
        account: p.account,
        amountPaise: p.amountPaise,
        paidAt: p.paidAtUtc.toLocal(),
        status: p.status,
      ),
  ]);
});

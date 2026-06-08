import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/format/formats.dart';
import '../../../l10n/l10n.dart';
import '../data/payment.dart';
import 'history_screen_data.dart';
import 'history_screen_data_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(historyScreenDataProvider);
    return Scaffold(
      appBar: AppBar(title: Text(ref.l10n.paymentHistory)),
      body: switch (data) {
        HistoryEmpty() => Center(child: Text(ref.l10n.noPaymentsYet)),
        HistoryLoaded(:final items) => ListView.builder(
            itemExtent: 80,
            itemCount: items.length,
            itemBuilder: (context, index) => _PaymentTile(item: items[index]),
          ),
      },
    );
  }
}

class _PaymentTile extends ConsumerWidget {
  const _PaymentTile({required this.item});

  final PaymentListItemData item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = ref.l10n;
    final (label, color) = switch (item.status) {
      PaymentStatus.processing => (l10n.statusProcessing, scheme.secondary),
      PaymentStatus.success => (l10n.statusSuccess, scheme.primary),
      PaymentStatus.failed => (l10n.statusFailed, scheme.error),
    };
    return ListTile(
      title: Text(item.billerName),
      subtitle: Text(
          '${item.account} · ${formatDate(item.paidAt, ref.languageCode)}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formatPaise(item.amountPaise, ref.languageCode),
              style: Theme.of(context).textTheme.titleMedium),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
      onTap: () => context.go('/payment/${item.id}'),
    );
  }
}

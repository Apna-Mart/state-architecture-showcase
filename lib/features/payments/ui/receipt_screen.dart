import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/format/formats.dart';
import '../../../l10n/l10n.dart';
import '../../saved_billers/data/saved_biller.dart';
import '../../saved_billers/data/saved_billers_provider.dart';
import '../data/payments_provider.dart';
import 'receipt_screen_data.dart';
import 'receipt_screen_data_provider.dart';

class ReceiptScreen extends ConsumerWidget {
  const ReceiptScreen({super.key, required this.paymentId});

  final String paymentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(receiptScreenDataProvider(paymentId));
    return Scaffold(
      appBar: AppBar(title: Text(ref.l10n.payment)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: switch (data) {
          ReceiptLoading() =>
            const Center(child: CircularProgressIndicator()),
          ReceiptNotFound() => Center(child: Text(ref.l10n.paymentNotFound)),
          ReceiptProcessing() => _Processing(data: data),
          ReceiptSuccess() => _Success(data: data),
          ReceiptFailed() => _Failed(data: data),
        },
      ),
    );
  }
}

class _Processing extends ConsumerWidget {
  const _Processing({required this.data});

  final ReceiptProcessing data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(ref.l10n.payingAmountTo(
              formatPaise(data.amountPaise, ref.languageCode),
              data.billerName)),
        ],
      ),
    );
  }
}

class _Success extends ConsumerWidget {
  const _Success({required this.data});

  final ReceiptSuccess data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Icon(Icons.check_circle,
            size: 64, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 16),
        Text(formatPaise(data.amountPaise, ref.languageCode),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium),
        Text(ref.l10n.paidTo(data.billerName), textAlign: TextAlign.center),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ref.l10n.receiptNumber(data.paymentId)),
                Text(ref.l10n.accountValue(data.account)),
                Text(ref.l10n.dateValue(
                    formatDate(data.paidAt, ref.languageCode))),
              ],
            ),
          ),
        ),
        const Spacer(),
        if (data.canSaveBiller)
          OutlinedButton.icon(
            onPressed: () => ref.read(savedBillersProvider.notifier).save(
                SavedBiller(
                    billerId: data.billerId,
                    account: data.account,
                    nickname: data.billerName)),
            icon: const Icon(Icons.bookmark_add),
            label: Text(ref.l10n.saveBiller),
          ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () => context.go('/'),
          child: Text(ref.l10n.done),
        ),
      ],
    );
  }
}

class _Failed extends ConsumerWidget {
  const _Failed({required this.data});

  final ReceiptFailed data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Icon(Icons.error, size: 64, color: Theme.of(context).colorScheme.error),
        const SizedBox(height: 16),
        Text(
            ref.l10n.paymentFailedSummary(
                formatPaise(data.amountPaise, ref.languageCode),
                data.billerName),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        FilledButton(
          onPressed: () {
            final paymentId = ref.read(paymentsProvider.notifier).pay(
                billerId: data.billerId,
                billerName: data.billerName,
                categoryId: data.categoryId,
                account: data.account,
                amountPaise: data.amountPaise);
            if (paymentId != null) context.go('/payment/$paymentId');
          },
          child: Text(ref.l10n.retryPayment),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => context.go('/'),
          child: Text(ref.l10n.backToHome),
        ),
      ],
    );
  }
}

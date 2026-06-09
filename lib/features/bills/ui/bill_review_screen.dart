import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/format/formats.dart';
import '../../../l10n/l10n.dart';
import '../../payments/data/payments_provider.dart';
import '../data/fetched_bill_provider.dart';
import 'bill_review_screen_data.dart';
import 'bill_review_screen_data_provider.dart';

enum _ReviewShape { loading, error, loaded }

class BillReviewScreen extends ConsumerWidget {
  const BillReviewScreen({
    super.key,
    required this.billerId,
    required this.account,
    this.amountPaise,
  });

  final String billerId;
  final String account;
  final int? amountPaise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params =
        (billerId: billerId, account: account, amountPaise: amountPaise);
    final shape = ref.watch(
        billReviewScreenDataProvider(params).select((d) => switch (d) {
              BillReviewLoading() => _ReviewShape.loading,
              BillReviewError() => _ReviewShape.error,
              BillReviewLoaded() => _ReviewShape.loaded,
            }));
    return Scaffold(
      appBar: AppBar(title: Text(ref.l10n.reviewAndPay)),
      body: switch (shape) {
        _ReviewShape.loading =>
          const Center(child: CircularProgressIndicator()),
        _ReviewShape.error => _ReviewError(params: params),
        _ReviewShape.loaded => _ReviewBody(params: params),
      },
    );
  }
}

class _ReviewError extends ConsumerWidget {
  const _ReviewError({required this.params});

  final ReviewParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ref.l10n.somethingWentWrong),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => ref.invalidate(fetchedBillProvider(
                (billerId: params.billerId, account: params.account))),
            child: Text(ref.l10n.retry),
          ),
        ],
      ),
    );
  }
}

class _ReviewBody extends StatelessWidget {
  const _ReviewBody({required this.params});

  final ReviewParams params;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ReviewCard(params: params),
          const Spacer(),
          _PayButton(params: params),
        ],
      ),
    );
  }
}

class _ReviewCard extends ConsumerWidget {
  const _ReviewCard({required this.params});

  final ReviewParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary =
        ref.watch(billReviewScreenDataProvider(params).select((d) =>
            d is BillReviewLoaded
                ? (
                    billerName: d.billerName,
                    account: d.account,
                    customerName: d.customerName,
                    dueInDays: d.dueInDays,
                    amountPaise: d.amountPaise,
                  )
                : null));
    if (summary == null) return const SizedBox.shrink();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(summary.billerName,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(ref.l10n.accountValue(summary.account)),
            if (summary.customerName != null)
              Text(ref.l10n.nameValue(summary.customerName!)),
            if (summary.dueInDays != null)
              Text(dueLabel(ref.l10n, summary.dueInDays!)),
            const SizedBox(height: 16),
            Text(
                formatPaise(summary.amountPaise, ref.languageCode),
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}

class _PayButton extends ConsumerWidget {
  const _PayButton({required this.params});

  final ReviewParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(billReviewScreenDataProvider(params).select((d) =>
            d is BillReviewLoaded
                ? (canPay: d.canPay, paying: d.paying, amountPaise: d.amountPaise)
                : null));
    if (state == null) return const SizedBox.shrink();
    final locale = ref.languageCode;
    return FilledButton(
      onPressed: state.canPay ? () => _pay(context, ref) : null,
      child: state.paying
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2))
          : Text(ref.l10n.payAmount(formatPaise(state.amountPaise, locale))),
    );
  }

  void _pay(BuildContext context, WidgetRef ref) {
    final data = ref.read(billReviewScreenDataProvider(params));
    if (data is! BillReviewLoaded) return;
    final paymentId = ref.read(paymentsProvider.notifier).pay(
        billerId: data.billerId,
        billerName: data.billerName,
        categoryId: data.categoryId,
        account: data.account,
        amountPaise: data.amountPaise);
    if (paymentId != null) context.go('/payment/$paymentId');
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/auth_provider.dart';
import '../../saved_billers/data/saved_billers_provider.dart';
import '../data/payment.dart';
import '../data/payments_provider.dart';
import 'receipt_screen_data.dart';

final receiptScreenDataProvider =
    Provider.autoDispose.family<ReceiptScreenData, String>((ref, paymentId) {
  final authed =
      ref.watch(authProvider.select((a) => a.userIdOrNull)) != null;
  if (!authed) return const ReceiptScreenData.loading();
  final payment = ref.watch(paymentsProvider.select((p) => p.byId(paymentId)));
  if (payment == null) return const ReceiptScreenData.notFound();
  final saved = ref.watch(savedBillersProvider);
  return switch (payment.status) {
    PaymentStatus.processing => ReceiptScreenData.processing(
        billerName: payment.billerName,
        amountPaise: payment.amountPaise),
    PaymentStatus.success => ReceiptScreenData.success(
        paymentId: payment.id,
        billerId: payment.billerId,
        billerName: payment.billerName,
        account: payment.account,
        amountPaise: payment.amountPaise,
        paidAt: payment.paidAtUtc.toLocal(),
        canSaveBiller: !saved.contains(payment.billerId, payment.account)),
    PaymentStatus.failed => ReceiptScreenData.failed(
        billerId: payment.billerId,
        billerName: payment.billerName,
        categoryId: payment.categoryId,
        account: payment.account,
        amountPaise: payment.amountPaise),
  };
});

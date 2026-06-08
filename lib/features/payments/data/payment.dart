import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';

enum PaymentStatus { processing, success, failed }

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String billerId,
    required String billerName,
    required String categoryId,
    required String account,
    required int amountPaise,
    required DateTime paidAtUtc,
    required PaymentStatus status,
  }) = _Payment;
}

@freezed
abstract class Payments with _$Payments {
  const Payments._();

  const factory Payments({
    required List<Payment> items,
    required int nextId,
  }) = _Payments;

  factory Payments.empty() => const Payments(items: [], nextId: 1);

  Payment? byId(String id) => items.where((p) => p.id == id).firstOrNull;

  bool hasProcessing(String billerId, String account) => items.any((p) =>
      p.billerId == billerId &&
      p.account == account &&
      p.status == PaymentStatus.processing);

  Payments adding(Payment payment) =>
      Payments(items: [...items, payment], nextId: nextId + 1);

  Payments updatingStatus(String id, PaymentStatus status) => copyWith(
      items: [
        for (final p in items) p.id == id ? p.copyWith(status: status) : p
      ]);
}

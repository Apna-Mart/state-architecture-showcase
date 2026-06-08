import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/key_value_store.dart';
import 'payment.dart';

abstract interface class PaymentHistoryRepository {
  Payments restore(String userId);
  Future<void> persist(String userId, Payments value);
}

class StoredPaymentHistoryRepository implements PaymentHistoryRepository {
  StoredPaymentHistoryRepository(this._store);

  final KeyValueStore _store;

  static String _keyFor(String userId) => 'payments.$userId';

  @override
  Payments restore(String userId) {
    final raw = _store.read(_keyFor(userId));
    if (raw == null) return Payments.empty();
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final items = decoded['items'] as List<dynamic>;
    return Payments(
      nextId: decoded['nextId'] as int,
      items: [
        for (final entry in items.cast<Map<String, dynamic>>())
          _decodePayment(entry),
      ],
    );
  }

  static Payment _decodePayment(Map<String, dynamic> entry) {
    final status = PaymentStatus.values.byName(entry['status'] as String);
    return Payment(
      id: entry['id'] as String,
      billerId: entry['billerId'] as String,
      billerName: entry['billerName'] as String,
      categoryId: entry['categoryId'] as String,
      account: entry['account'] as String,
      amountPaise: entry['amountPaise'] as int,
      paidAtUtc: DateTime.parse(entry['paidAtUtc'] as String),
      status:
          status == PaymentStatus.processing ? PaymentStatus.failed : status,
    );
  }

  @override
  Future<void> persist(String userId, Payments value) =>
      _store.write(_keyFor(userId), jsonEncode({
        'nextId': value.nextId,
        'items': [
          for (final p in value.items)
            {
              'id': p.id,
              'billerId': p.billerId,
              'billerName': p.billerName,
              'categoryId': p.categoryId,
              'account': p.account,
              'amountPaise': p.amountPaise,
              'paidAtUtc': p.paidAtUtc.toIso8601String(),
              'status': p.status.name,
            },
        ],
      }));
}

final paymentHistoryRepositoryProvider = Provider<PaymentHistoryRepository>(
  (ref) => StoredPaymentHistoryRepository(ref.watch(keyValueStoreProvider)),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/event/ui_event.dart';
import '../../../core/time/clock.dart';
import '../../auth/data/auth_provider.dart';
import '../../bills/data/due_bills_provider.dart';
import '../../bills/data/fetched_bill_provider.dart';
import 'payment.dart';
import 'payment_history_repository.dart';
import 'payment_repository.dart';

final paymentsProvider =
    NotifierProvider<PaymentsNotifier, Payments>(PaymentsNotifier.new);

class PaymentsNotifier extends Notifier<Payments> {
  int _epoch = 0;
  (String, Payments)? _pendingWrite;
  Future<void>? _flush;

  @override
  Payments build() {
    final userId = ref.watch(authProvider.select((a) => a.userIdOrNull));
    _epoch++;
    if (userId == null) return Payments.empty();
    listenSelf((_, next) => _enqueuePersist(userId, next));
    return ref.read(paymentHistoryRepositoryProvider).restore(userId);
  }

  void _enqueuePersist(String userId, Payments next) {
    _pendingWrite = (userId, next);
    _flush ??= _drainWrites();
  }

  Future<void> _drainWrites() async {
    while (_pendingWrite != null) {
      final (userId, snapshot) = _pendingWrite!;
      _pendingWrite = null;
      try {
        await ref
            .read(paymentHistoryRepositoryProvider)
            .persist(userId, snapshot);
      } catch (_) {
        if (!ref.mounted) return;
        ref.read(uiEventProvider.notifier).emit(const UiEvent.storageFailed());
      }
    }
    _flush = null;
  }

  String? pay({
    required String billerId,
    required String billerName,
    required String categoryId,
    required String account,
    required int amountPaise,
  }) {
    if (state.hasProcessing(billerId, account)) return null;
    final payment = Payment(
      id: 'pay-${state.nextId}',
      billerId: billerId,
      billerName: billerName,
      categoryId: categoryId,
      account: account,
      amountPaise: amountPaise,
      paidAtUtc: ref.read(clockProvider)().toUtc(),
      status: PaymentStatus.processing,
    );
    state = state.adding(payment);
    _process(payment);
    return payment.id;
  }

  Future<void> _process(Payment payment) async {
    final epoch = _epoch;
    try {
      await ref.read(paymentRepositoryProvider).pay(payment);
      if (epoch != _epoch || !ref.mounted) return;
      state = state.updatingStatus(payment.id, PaymentStatus.success);
      ref
          .read(dueBillsProvider.notifier)
          .removePaid(payment.billerId, payment.account);
      ref.invalidate(fetchedBillProvider(
          (billerId: payment.billerId, account: payment.account)));
    } catch (_) {
      if (epoch != _epoch || !ref.mounted) return;
      state = state.updatingStatus(payment.id, PaymentStatus.failed);
      ref
          .read(uiEventProvider.notifier)
          .emit(UiEvent.paymentFailed(payment.id));
    }
  }
}

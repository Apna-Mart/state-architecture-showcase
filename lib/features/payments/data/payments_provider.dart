import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/event/ui_event.dart';
import '../../../core/time/clock.dart';
import '../../auth/data/auth_provider.dart';
import '../../bills/data/due_bills_provider.dart';
import 'payment.dart';
import 'payment_history_repository.dart';
import 'payment_repository.dart';

final paymentsProvider =
    NotifierProvider<PaymentsNotifier, Payments>(PaymentsNotifier.new);

class PaymentsNotifier extends Notifier<Payments> {
  int _epoch = 0;

  @override
  Payments build() {
    final userId = ref.watch(authProvider.select((a) => a.userIdOrNull));
    _epoch++;
    if (userId == null) return Payments.empty();
    final repository = ref.read(paymentHistoryRepositoryProvider);
    listenSelf((_, next) async {
      try {
        await repository.persist(userId, next);
      } catch (_) {
        ref.read(uiEventProvider.notifier).emit(const UiEvent.storageFailed());
      }
    });
    return repository.restore(userId);
  }

  Future<void> pay({
    required String billerId,
    required String billerName,
    required String categoryId,
    required String account,
    required int amountPaise,
  }) async {
    if (state.hasProcessing(billerId, account)) return;
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
    final events = ref.read(uiEventProvider.notifier);
    events.emit(UiEvent.paymentStarted(payment.id));
    final epoch = _epoch;
    try {
      await ref.read(paymentRepositoryProvider).pay(payment);
      if (epoch != _epoch) return;
      state = state.updatingStatus(payment.id, PaymentStatus.success);
      ref.invalidate(dueBillsProvider);
    } catch (_) {
      if (epoch != _epoch) return;
      state = state.updatingStatus(payment.id, PaymentStatus.failed);
      events.emit(UiEvent.paymentFailed(payment.id));
    }
  }
}

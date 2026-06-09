import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_event.freezed.dart';

@freezed
sealed class UiEvent with _$UiEvent {
  const factory UiEvent.paymentFailed(String paymentId) = PaymentFailed;
  const factory UiEvent.otpRejected() = OtpRejected;
  const factory UiEvent.authFailed() = AuthFailed;
  const factory UiEvent.storageFailed() = StorageFailed;
}

class QueuedUiEvent {
  const QueuedUiEvent(this.seq, this.event);

  final int seq;
  final UiEvent event;
}

final uiEventProvider =
    NotifierProvider<UiEventNotifier, List<QueuedUiEvent>>(UiEventNotifier.new);

class UiEventNotifier extends Notifier<List<QueuedUiEvent>> {
  int _nextSeq = 0;

  @override
  List<QueuedUiEvent> build() => const [];

  void emit(UiEvent event) =>
      state = [...state, QueuedUiEvent(_nextSeq++, event)];

  void consumeThrough(int seq) =>
      state = [for (final queued in state) if (queued.seq > seq) queued];
}

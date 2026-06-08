import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_event.freezed.dart';

@freezed
sealed class UiEvent with _$UiEvent {
  const factory UiEvent.paymentStarted(String paymentId) = PaymentStarted;
  const factory UiEvent.paymentFailed(String paymentId) = PaymentFailed;
  const factory UiEvent.otpRejected() = OtpRejected;
  const factory UiEvent.authFailed() = AuthFailed;
  const factory UiEvent.storageFailed() = StorageFailed;
}

final uiEventProvider =
    NotifierProvider<UiEventNotifier, List<UiEvent>>(UiEventNotifier.new);

class UiEventNotifier extends Notifier<List<UiEvent>> {
  @override
  List<UiEvent> build() => const [];

  void emit(UiEvent event) => state = [...state, event];

  void consume(UiEvent event) {
    final index = state.indexOf(event);
    if (index < 0) return;
    state = [...state]..removeAt(index);
  }
}

import 'package:billpayments/core/event/ui_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emit appends and consume removes exactly one occurrence', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(uiEventProvider.notifier);

    notifier.emit(const UiEvent.paymentFailed('p1'));
    notifier.emit(const UiEvent.paymentFailed('p1'));
    expect(container.read(uiEventProvider).length, 2);

    notifier.consume(const UiEvent.paymentFailed('p1'));
    expect(container.read(uiEventProvider).length, 1);

    notifier.consume(const UiEvent.paymentFailed('p1'));
    expect(container.read(uiEventProvider), isEmpty);
  });

  test('consume of absent event is a no-op', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container
        .read(uiEventProvider.notifier)
        .consume(const UiEvent.otpRejected());
    expect(container.read(uiEventProvider), isEmpty);
  });
}

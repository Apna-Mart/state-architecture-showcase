import 'package:billpayments/core/event/ui_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emit assigns increasing seq so identical events stay distinct', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(uiEventProvider.notifier);

    notifier.emit(const UiEvent.paymentFailed('p1'));
    notifier.emit(const UiEvent.paymentFailed('p1'));
    final events = container.read(uiEventProvider);
    expect(events.map((q) => q.seq), [0, 1]);
    expect(events.map((q) => q.event),
        everyElement(const UiEvent.paymentFailed('p1')));
  });

  test('consumeThrough drops everything up to seq and keeps newer', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(uiEventProvider.notifier);

    notifier.emit(const UiEvent.storageFailed());
    notifier.emit(const UiEvent.otpRejected());
    notifier.consumeThrough(0);
    expect(container.read(uiEventProvider).single.event,
        const UiEvent.otpRejected());

    notifier.consumeThrough(1);
    expect(container.read(uiEventProvider), isEmpty);
  });

  test('consumeThrough on empty queue is a no-op', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(uiEventProvider.notifier).consumeThrough(5);
    expect(container.read(uiEventProvider), isEmpty);
  });

  test('events emitted while draining are not lost', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(uiEventProvider.notifier);

    notifier.emit(const UiEvent.storageFailed());
    final drained = container.read(uiEventProvider);
    notifier.emit(const UiEvent.authFailed());
    notifier.consumeThrough(drained.last.seq);
    expect(container.read(uiEventProvider).single.event,
        const UiEvent.authFailed());
  });
}

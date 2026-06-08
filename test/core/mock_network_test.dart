import 'package:billpayments/core/mock/mock_network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('delay completes within configured bounds', () async {
    final network = MockNetwork(minDelayMs: 1, maxDelayMs: 2);
    final stopwatch = Stopwatch()..start();
    await network.delay();
    expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(1));
    expect(stopwatch.elapsedMilliseconds, lessThan(2000));
  });

  test('countAndMaybeFail throws on every nth call', () {
    final network = MockNetwork(minDelayMs: 0, maxDelayMs: 1, failEvery: 3);
    network.countAndMaybeFail();
    network.countAndMaybeFail();
    expect(network.countAndMaybeFail, throwsA(isA<MockPaymentDeclined>()));
    network.countAndMaybeFail();
    network.countAndMaybeFail();
    expect(network.countAndMaybeFail, throwsA(isA<MockPaymentDeclined>()));
  });

  test('seeded delays are deterministic across instances', () async {
    final a = MockNetwork(minDelayMs: 1, maxDelayMs: 50);
    final b = MockNetwork(minDelayMs: 1, maxDelayMs: 50);
    expect(a.nextDelayMs(), b.nextDelayMs());
    expect(a.nextDelayMs(), b.nextDelayMs());
  });
}

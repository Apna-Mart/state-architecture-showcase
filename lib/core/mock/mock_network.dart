import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockPaymentDeclined implements Exception {
  const MockPaymentDeclined();
}

class MockNetwork {
  MockNetwork({
    this.minDelayMs = 300,
    this.maxDelayMs = 800,
    this.failEvery = 10,
    int seed = 42,
  }) : _random = Random(seed);

  final int minDelayMs;
  final int maxDelayMs;
  final int failEvery;
  final Random _random;
  int _failCounter = 0;

  int nextDelayMs() =>
      minDelayMs + _random.nextInt(max(1, maxDelayMs - minDelayMs));

  Future<void> delay([int times = 1]) =>
      Future<void>.delayed(Duration(milliseconds: nextDelayMs() * times));

  void countAndMaybeFail() {
    _failCounter++;
    if (_failCounter % failEvery == 0) throw const MockPaymentDeclined();
  }
}

final mockNetworkProvider = Provider<MockNetwork>((ref) => MockNetwork());

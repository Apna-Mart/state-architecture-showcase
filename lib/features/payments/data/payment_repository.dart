import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_network.dart';
import 'payment.dart';

abstract interface class PaymentRepository {
  Future<void> pay(Payment payment);
}

class FakePaymentRepository implements PaymentRepository {
  FakePaymentRepository(this._network);

  final MockNetwork _network;

  @override
  Future<void> pay(Payment payment) async {
    await _network.delay();
    _network.countAndMaybeFail();
  }
}

final paymentRepositoryProvider = Provider<PaymentRepository>(
  (ref) => FakePaymentRepository(ref.watch(mockNetworkProvider)),
);

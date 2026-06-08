import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_network.dart';

class InvalidOtpException implements Exception {
  const InvalidOtpException();
}

abstract interface class AuthRepository {
  Future<void> sendOtp(String phone);
  Future<String> verifyOtp(String phone, String code);
}

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository(this._network);

  final MockNetwork _network;

  @override
  Future<void> sendOtp(String phone) => _network.delay();

  @override
  Future<String> verifyOtp(String phone, String code) async {
    await _network.delay();
    final isSixDigits = code.length == 6 && int.tryParse(code) != null;
    if (!isSixDigits) throw const InvalidOtpException();
    return 'user-$phone';
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => FakeAuthRepository(ref.watch(mockNetworkProvider)),
);

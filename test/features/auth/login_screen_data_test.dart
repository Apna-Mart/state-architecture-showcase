import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/auth/ui/login_inputs_provider.dart';
import 'package:billpayments/features/auth/ui/login_screen_data.dart';
import 'package:billpayments/features/auth/ui/login_screen_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer instantContainer() {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider
        .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
  ]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('initial state is phone entry with send disabled', () {
    final container = instantContainer();
    expect(
      container.read(loginScreenDataProvider),
      const LoginScreenData.phoneEntry(canSend: false, sending: false),
    );
  });

  test('ten digit phone enables send', () {
    final container = instantContainer();
    final sub = container.listen(loginScreenDataProvider, (_, _) {});
    container.read(loginPhoneProvider.notifier).edit('9876543210');
    expect(
      container.read(loginScreenDataProvider),
      const LoginScreenData.phoneEntry(canSend: true, sending: false),
    );
    sub.close();
  });

  test('otpSent projects otp entry and six digits enable verify', () async {
    final container = instantContainer();
    final sub = container.listen(loginScreenDataProvider, (_, _) {});
    await container.read(authProvider.notifier).sendOtp('9876543210');
    expect(
      container.read(loginScreenDataProvider),
      const LoginScreenData.otpEntry(
          phone: '9876543210', canVerify: false, verifying: false),
    );
    container.read(loginOtpProvider.notifier).edit('123456');
    expect(
      container.read(loginScreenDataProvider),
      const LoginScreenData.otpEntry(
          phone: '9876543210', canVerify: true, verifying: false),
    );
    sub.close();
  });
}

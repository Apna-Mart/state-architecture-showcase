import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth.dart';
import '../data/auth_provider.dart';
import 'login_inputs_provider.dart';
import 'login_screen_data.dart';

final loginScreenDataProvider = Provider.autoDispose<LoginScreenData>((ref) {
  final auth = ref.watch(authProvider);
  final phoneInput = ref.watch(loginPhoneProvider);
  final otpInput = ref.watch(loginOtpProvider);
  final validPhone =
      phoneInput.length == 10 && int.tryParse(phoneInput) != null;
  return switch (auth) {
    Unauthenticated() =>
      LoginScreenData.phoneEntry(canSend: validPhone, sending: false),
    SendingOtp() =>
      const LoginScreenData.phoneEntry(canSend: false, sending: true),
    OtpSent(:final phone) => LoginScreenData.otpEntry(
        phone: phone, canVerify: otpInput.length == 6, verifying: false),
    Verifying(:final phone) => LoginScreenData.otpEntry(
        phone: phone, canVerify: false, verifying: true),
    Authenticated() =>
      const LoginScreenData.phoneEntry(canSend: false, sending: false),
  };
});

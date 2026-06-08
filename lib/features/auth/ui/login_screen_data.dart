import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_screen_data.freezed.dart';

@freezed
sealed class LoginScreenData with _$LoginScreenData {
  const factory LoginScreenData.phoneEntry({
    required bool canSend,
    required bool sending,
  }) = LoginPhoneEntry;

  const factory LoginScreenData.otpEntry({
    required String phone,
    required bool canVerify,
    required bool verifying,
  }) = LoginOtpEntry;
}

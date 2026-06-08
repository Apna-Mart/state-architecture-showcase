import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
sealed class Auth with _$Auth {
  const Auth._();

  const factory Auth.unauthenticated() = Unauthenticated;
  const factory Auth.sendingOtp(String phone) = SendingOtp;
  const factory Auth.otpSent(String phone) = OtpSent;
  const factory Auth.verifying(String phone) = Verifying;
  const factory Auth.authenticated({
    required String userId,
    required String phone,
  }) = Authenticated;

  String? get userIdOrNull => switch (this) {
        Authenticated(:final userId) => userId,
        _ => null,
      };
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPhoneProvider =
    NotifierProvider.autoDispose<LoginPhoneNotifier, String>(
        LoginPhoneNotifier.new);

class LoginPhoneNotifier extends Notifier<String> {
  @override
  String build() => '';

  void edit(String value) => state = value;
}

final loginOtpProvider = NotifierProvider.autoDispose<LoginOtpNotifier, String>(
    LoginOtpNotifier.new);

class LoginOtpNotifier extends Notifier<String> {
  @override
  String build() => '';

  void edit(String value) => state = value;
}

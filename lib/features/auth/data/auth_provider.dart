import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/event/ui_event.dart';
import 'auth.dart';
import 'auth_repository.dart';
import 'session_repository.dart';

final authProvider = NotifierProvider<AuthNotifier, Auth>(AuthNotifier.new);

class AuthNotifier extends Notifier<Auth> {
  @override
  Auth build() {
    final session = ref.read(sessionRepositoryProvider).restore();
    if (session == null) return const Auth.unauthenticated();
    return Auth.authenticated(userId: session.userId, phone: session.phone);
  }

  Future<void> sendOtp(String phone) async {
    if (state is SendingOtp || state is Verifying) return;
    state = Auth.sendingOtp(phone);
    try {
      await ref.read(authRepositoryProvider).sendOtp(phone);
      state = Auth.otpSent(phone);
    } catch (_) {
      state = const Auth.unauthenticated();
      ref.read(uiEventProvider.notifier).emit(const UiEvent.authFailed());
    }
  }

  Future<void> verifyOtp(String code) async {
    final current = state;
    if (current is! OtpSent) return;
    state = Auth.verifying(current.phone);
    try {
      final userId =
          await ref.read(authRepositoryProvider).verifyOtp(current.phone, code);
      state = Auth.authenticated(userId: userId, phone: current.phone);
      await ref.read(sessionRepositoryProvider).save(userId, current.phone);
    } on InvalidOtpException {
      state = Auth.otpSent(current.phone);
      ref.read(uiEventProvider.notifier).emit(const UiEvent.otpRejected());
    } catch (_) {
      state = Auth.otpSent(current.phone);
      ref.read(uiEventProvider.notifier).emit(const UiEvent.authFailed());
    }
  }

  void logout() {
    ref.read(sessionRepositoryProvider).clear();
    state = const Auth.unauthenticated();
  }
}

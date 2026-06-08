import 'package:billpayments/core/event/ui_event.dart';
import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/auth/data/auth.dart';
import 'package:billpayments/features/auth/data/auth_provider.dart';
import 'package:billpayments/features/auth/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _ExplodingAuthRepository implements AuthRepository {
  _ExplodingAuthRepository({this.failSend = false});

  final bool failSend;

  @override
  Future<void> sendOtp(String phone) async {
    if (failSend) throw Exception('network down');
  }

  @override
  Future<String> verifyOtp(String phone, String code) async =>
      throw Exception('network down');
}

ProviderContainer instantContainer() {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider
        .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
  ]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('sendOtp transitions unauthenticated to otpSent', () async {
    final container = instantContainer();
    await container.read(authProvider.notifier).sendOtp('9876543210');
    expect(container.read(authProvider), const Auth.otpSent('9876543210'));
  });

  test('verifyOtp with six digits authenticates with deterministic userId',
      () async {
    final container = instantContainer();
    final notifier = container.read(authProvider.notifier);
    await notifier.sendOtp('9876543210');
    await notifier.verifyOtp('123456');
    expect(
      container.read(authProvider),
      const Auth.authenticated(userId: 'user-9876543210', phone: '9876543210'),
    );
  });

  test('verifyOtp with bad code returns to otpSent and emits otpRejected',
      () async {
    final container = instantContainer();
    final notifier = container.read(authProvider.notifier);
    await notifier.sendOtp('9876543210');
    await notifier.verifyOtp('12');
    expect(container.read(authProvider), const Auth.otpSent('9876543210'));
    expect(container.read(uiEventProvider), const [UiEvent.otpRejected()]);
  });

  test('sendOtp re-entry while in flight is ignored', () async {
    final container = instantContainer();
    final notifier = container.read(authProvider.notifier);
    final first = notifier.sendOtp('9876543210');
    final second = notifier.sendOtp('1111111111');
    await Future.wait([first, second]);
    expect(container.read(authProvider), const Auth.otpSent('9876543210'));
  });

  test('verifyOtp network failure restores otpSent and emits authFailed',
      () async {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(_ExplodingAuthRepository()),
    ]);
    addTearDown(container.dispose);
    final notifier = container.read(authProvider.notifier);
    await notifier.sendOtp('9876543210');
    await notifier.verifyOtp('123456');
    expect(container.read(authProvider), const Auth.otpSent('9876543210'));
    expect(container.read(uiEventProvider), const [UiEvent.authFailed()]);
  });

  test('sendOtp network failure restores unauthenticated and emits authFailed',
      () async {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider
          .overrideWithValue(_ExplodingAuthRepository(failSend: true)),
    ]);
    addTearDown(container.dispose);
    await container.read(authProvider.notifier).sendOtp('9876543210');
    expect(container.read(authProvider), const Auth.unauthenticated());
    expect(container.read(uiEventProvider), const [UiEvent.authFailed()]);
  });

  test('logout resets to unauthenticated', () async {
    final container = instantContainer();
    final notifier = container.read(authProvider.notifier);
    await notifier.sendOtp('9876543210');
    await notifier.verifyOtp('123456');
    notifier.logout();
    expect(container.read(authProvider), const Auth.unauthenticated());
  });
}

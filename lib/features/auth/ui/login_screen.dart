import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../data/auth_provider.dart';
import 'login_inputs_provider.dart';
import 'login_screen_data.dart';
import 'login_screen_data_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpPhase = ref
        .watch(loginScreenDataProvider.select((d) => d is LoginOtpEntry));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: otpPhase ? const _OtpEntry() : const _PhoneEntry(),
        ),
      ),
    );
  }
}

class _PhoneEntry extends ConsumerStatefulWidget {
  const _PhoneEntry();

  @override
  ConsumerState<_PhoneEntry> createState() => _PhoneEntryState();
}

class _PhoneEntryState extends ConsumerState<_PhoneEntry> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(ref.l10n.appTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: 32),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: InputDecoration(
              labelText: ref.l10n.mobileNumber, border: const OutlineInputBorder()),
          onChanged: (value) =>
              ref.read(loginPhoneProvider.notifier).edit(value),
        ),
        const SizedBox(height: 16),
        const _SendOtpButton(),
      ],
    );
  }
}

class _SendOtpButton extends ConsumerWidget {
  const _SendOtpButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginScreenDataProvider.select((d) =>
        d is LoginPhoneEntry
            ? (canSend: d.canSend, sending: d.sending)
            : (canSend: false, sending: false)));
    return FilledButton(
      onPressed: state.canSend
          ? () => ref
              .read(authProvider.notifier)
              .sendOtp(ref.read(loginPhoneProvider))
          : null,
      child: state.sending
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2))
          : Text(ref.l10n.sendOtp),
    );
  }
}

class _OtpEntry extends ConsumerStatefulWidget {
  const _OtpEntry();

  @override
  ConsumerState<_OtpEntry> createState() => _OtpEntryState();
}

class _OtpEntryState extends ConsumerState<_OtpEntry> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _OtpHeader(),
        const SizedBox(height: 32),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
              labelText: ref.l10n.enterOtp, border: const OutlineInputBorder()),
          onChanged: (value) => ref.read(loginOtpProvider.notifier).edit(value),
        ),
        const SizedBox(height: 16),
        const _VerifyButton(),
        TextButton(
          onPressed: () => ref.read(authProvider.notifier).logout(),
          child: Text(ref.l10n.changeNumber),
        ),
      ],
    );
  }
}

class _OtpHeader extends ConsumerWidget {
  const _OtpHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = ref.watch(
        loginScreenDataProvider.select((d) => d is LoginOtpEntry ? d.phone : ''));
    return Text(ref.l10n.otpSentTo(phone),
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center);
  }
}

class _VerifyButton extends ConsumerWidget {
  const _VerifyButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginScreenDataProvider.select((d) =>
        d is LoginOtpEntry
            ? (canVerify: d.canVerify, verifying: d.verifying)
            : (canVerify: false, verifying: false)));
    return FilledButton(
      onPressed: state.canVerify
          ? () => ref
              .read(authProvider.notifier)
              .verifyOtp(ref.read(loginOtpProvider))
          : null,
      child: state.verifying
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2))
          : Text(ref.l10n.verify),
    );
  }
}

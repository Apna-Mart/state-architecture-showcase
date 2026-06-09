import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../billers/data/biller_catalog_provider.dart';
import 'bill_fetch_form_provider.dart';
import 'bill_fetch_screen_data.dart';
import 'bill_fetch_screen_data_provider.dart';

enum _FetchShape { loading, error, form }

class BillFetchScreen extends ConsumerWidget {
  const BillFetchScreen({super.key, required this.billerId});

  final String billerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shape = ref.watch(
        billFetchScreenDataProvider(billerId).select((d) => switch (d) {
              BillFetchLoading() => _FetchShape.loading,
              BillFetchError() => _FetchShape.error,
              BillFetchFormData() => _FetchShape.form,
            }));
    return Scaffold(
      appBar: AppBar(title: _FetchTitle(billerId: billerId)),
      body: switch (shape) {
        _FetchShape.loading =>
          const Center(child: CircularProgressIndicator()),
        _FetchShape.error => _FetchError(billerId: billerId),
        _FetchShape.form => _FetchForm(billerId: billerId),
      },
    );
  }
}

class _FetchTitle extends ConsumerWidget {
  const _FetchTitle({required this.billerId});

  final String billerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(billFetchScreenDataProvider(billerId)
        .select((d) => d is BillFetchFormData ? d.billerName : null)) ??
        ref.l10n.billDetails;
    return Text(title);
  }
}

class _FetchError extends ConsumerWidget {
  const _FetchError({required this.billerId});

  final String billerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ref.l10n.somethingWentWrong),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => ref.invalidate(billerCatalogProvider),
            child: Text(ref.l10n.retry),
          ),
        ],
      ),
    );
  }
}

class _FetchForm extends ConsumerWidget {
  const _FetchForm({required this.billerId});

  final String billerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputs = ref.watch(billFetchScreenDataProvider(billerId)
        .select((d) => d is BillFetchFormData ? d.inputs : null));
    if (inputs == null) return const SizedBox.shrink();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final field in inputs.fields) ...[
          _FetchField(field: field),
          const SizedBox(height: 16),
        ],
        if (inputs.showAmount) ...[
          const _AmountField(),
          const SizedBox(height: 16),
        ],
        _SubmitButton(billerId: billerId),
      ],
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton({required this.billerId});

  final String billerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submit = ref.watch(billFetchScreenDataProvider(billerId)
        .select((d) => d is BillFetchFormData ? d.submit : null));
    if (submit == null) return const SizedBox.shrink();
    return FilledButton(
      onPressed:
          submit.location == null ? null : () => context.go(submit.location!),
      child: Text(switch (submit.action) {
        FetchSubmitAction.fetchBill => ref.l10n.fetchBill,
        FetchSubmitAction.continueToReview => ref.l10n.continueLabel,
      }),
    );
  }
}

class _FetchField extends ConsumerStatefulWidget {
  const _FetchField({required this.field});

  final FetchFieldData field;

  @override
  ConsumerState<_FetchField> createState() => _FetchFieldState();
}

class _FetchFieldState extends ConsumerState<_FetchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: ref.read(billFetchFormProvider).valueOf(widget.field.key));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      inputFormatters: [FilteringTextInputFormatter.deny('|')],
      decoration: InputDecoration(
          labelText: widget.field.label,
          hintText: widget.field.hint,
          border: const OutlineInputBorder()),
      onChanged: (value) => ref
          .read(billFetchFormProvider.notifier)
          .editField(widget.field.key, value),
    );
  }
}

class _AmountField extends ConsumerStatefulWidget {
  const _AmountField();

  @override
  ConsumerState<_AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends ConsumerState<_AmountField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: ref.read(billFetchFormProvider).amountText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: ref.l10n.amountFieldLabel,
          hintText: ref.l10n.enterAmount,
          border: const OutlineInputBorder()),
      onChanged: (value) =>
          ref.read(billFetchFormProvider.notifier).editAmount(value),
    );
  }
}

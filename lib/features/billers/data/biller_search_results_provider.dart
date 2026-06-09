import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n_provider.dart';
import 'biller.dart';
import 'biller_repository.dart';

final billerSearchResultsProvider = AsyncNotifierProvider.autoDispose
    .family<BillerSearchResultsNotifier, List<Biller>, String>(
        BillerSearchResultsNotifier.new);

class BillerSearchResultsNotifier extends AsyncNotifier<List<Biller>> {
  BillerSearchResultsNotifier(this.query);

  final String query;

  static const debounce = Duration(milliseconds: 300);
  static const cacheTtl = Duration(minutes: 1);

  @override
  Future<List<Biller>> build() async {
    final language =
        ref.watch(l10nProvider.select((l) => l.locale.languageCode));
    if (query.trim().length < 2) return const [];
    await Future<void>.delayed(debounce);
    if (!ref.mounted) return const [];
    final results =
        await ref.read(billerRepositoryProvider).search(query, language);
    if (ref.mounted) _keepWarm();
    return results;
  }

  void _keepWarm() {
    final link = ref.keepAlive();
    final timer = Timer(cacheTtl, link.close);
    ref.onDispose(timer.cancel);
  }
}

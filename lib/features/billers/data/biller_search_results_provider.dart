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

  @override
  Future<List<Biller>> build() async {
    if (query.trim().length < 2) return const [];
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!ref.mounted) throw StateError('disposed');
    final language = ref.read(l10nProvider).locale.languageCode;
    return ref.read(billerRepositoryProvider).search(query, language);
  }
}

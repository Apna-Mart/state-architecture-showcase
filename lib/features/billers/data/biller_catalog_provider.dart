import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/stale_while_revalidate.dart';
import '../../../l10n/l10n_provider.dart';
import 'biller_catalog.dart';
import 'biller_repository.dart';

final billerCatalogProvider =
    AsyncNotifierProvider<BillerCatalogNotifier, BillerCatalog>(
        BillerCatalogNotifier.new);

class BillerCatalogNotifier extends AsyncNotifier<BillerCatalog>
    with StaleWhileRevalidate<BillerCatalog> {
  @override
  Duration get maxAge => const Duration(minutes: 30);

  @override
  Future<BillerCatalog> build() async {
    final language = ref.watch(l10nProvider).locale.languageCode;
    final catalog =
        await ref.watch(billerRepositoryProvider).fetchCatalog(language);
    markFetched();
    return catalog;
  }
}

import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:billpayments/features/billers/ui/search_query_provider.dart';
import 'package:billpayments/features/bills/data/due_bills_provider.dart';
import 'package:billpayments/features/bills/ui/bill_fetch_form_provider.dart';
import 'package:billpayments/features/home/ui/home_screen_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('search typing and form edits never notify home screen data', () async {
    final container = ProviderContainer(overrides: [
      mockNetworkProvider
          .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
    ]);
    addTearDown(container.dispose);
    await container.read(billerCatalogProvider.future);

    var notifications = 0;
    final sub =
        container.listen(homeScreenDataProvider, (_, _) => notifications++);
    await container.read(dueBillsProvider.future);
    await container.pump();
    notifications = 0;

    container.read(billerSearchQueryProvider.notifier).edit('metro');
    container.read(billerSearchQueryProvider.notifier).edit('metro elec');
    container.read(billFetchFormProvider.notifier).editField('account', 'K1');
    container.read(billFetchFormProvider.notifier).editAmount('250');
    await container.pump();

    expect(notifications, 0);
    sub.close();
  });
}

import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:billpayments/features/billers/ui/category_screen_data.dart';
import 'package:billpayments/features/billers/ui/category_screen_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('category projects loading then its four billers', () async {
    final container = ProviderContainer(overrides: [
      mockNetworkProvider
          .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
    ]);
    addTearDown(container.dispose);
    final sub =
        container.listen(categoryScreenDataProvider('water'), (_, _) {});
    expect(container.read(categoryScreenDataProvider('water')),
        const CategoryScreenData.loading());
    await container.read(billerCatalogProvider.future);
    await container.pump();
    final loaded =
        container.read(categoryScreenDataProvider('water')) as CategoryLoaded;
    expect(loaded.categoryName, 'Water');
    expect(loaded.billers.length, 4);
    expect(loaded.billers.first.categoryName, 'Water');
    sub.close();
  });
}

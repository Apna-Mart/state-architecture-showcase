import 'package:billpayments/core/mock/mock_network.dart';
import 'package:billpayments/features/billers/data/biller_catalog_provider.dart';
import 'package:billpayments/features/bills/ui/bill_fetch_form_provider.dart';
import 'package:billpayments/features/bills/ui/bill_fetch_screen_data.dart';
import 'package:billpayments/features/bills/ui/bill_fetch_screen_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer instantContainer() {
  final container = ProviderContainer(overrides: [
    mockNetworkProvider
        .overrideWithValue(MockNetwork(minDelayMs: 0, maxDelayMs: 1)),
  ]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('presentment biller submit enables once all fields filled', () async {
    final container = instantContainer();
    final provider = billFetchScreenDataProvider('electricity-metro');
    final sub = container.listen(provider, (_, _) {});
    await container.read(billerCatalogProvider.future);
    await container.pump();

    var form = container.read(provider) as BillFetchFormData;
    expect(form.billerName, 'Metro Electricity');
    expect(form.inputs.showAmount, isFalse);
    expect(form.submit.action, FetchSubmitAction.fetchBill);
    expect(form.submit.location, isNull);

    container.read(billFetchFormProvider.notifier).editField('account', 'K123');
    form = container.read(provider) as BillFetchFormData;
    expect(
        form.submit.location, '/biller/electricity-metro/review?account=K123');
    sub.close();
  });

  test('typing changes the submit slice but never the inputs slice', () async {
    final container = instantContainer();
    final provider = billFetchScreenDataProvider('electricity-metro');
    final sub = container.listen(provider, (_, _) {});
    await container.read(billerCatalogProvider.future);
    await container.pump();

    final before = (container.read(provider) as BillFetchFormData).inputs;
    container.read(billFetchFormProvider.notifier).editField('account', 'K123');
    final after = container.read(provider) as BillFetchFormData;
    expect(after.inputs, before);
    expect(after.submit.location, isNotNull);
    sub.close();
  });

  test('openAmount biller requires a positive amount', () async {
    final container = instantContainer();
    final provider = billFetchScreenDataProvider('dth-metro');
    final sub = container.listen(provider, (_, _) {});
    await container.read(billerCatalogProvider.future);
    await container.pump();

    final notifier = container.read(billFetchFormProvider.notifier);
    notifier.editField('account', 'D77');
    var form = container.read(provider) as BillFetchFormData;
    expect(form.inputs.showAmount, isTrue);
    expect(form.submit.action, FetchSubmitAction.continueToReview);
    expect(form.submit.location, isNull);

    notifier.editAmount('250');
    form = container.read(provider) as BillFetchFormData;
    expect(form.submit.location,
        '/biller/dth-metro/review?account=D77&amount=25000');
    sub.close();
  });

  test('credit card joins two field values into the account', () async {
    final container = instantContainer();
    final provider = billFetchScreenDataProvider('credit-card-city');
    final sub = container.listen(provider, (_, _) {});
    await container.read(billerCatalogProvider.future);
    await container.pump();

    final notifier = container.read(billFetchFormProvider.notifier);
    notifier.editField('card', '4321');
    notifier.editField('mobile', '9876543210');
    final form = container.read(provider) as BillFetchFormData;
    expect(form.inputs.fields.length, 2);
    expect(form.submit.location,
        '/biller/credit-card-city/review?account=${Uri.encodeQueryComponent('4321|9876543210')}');
    sub.close();
  });
}

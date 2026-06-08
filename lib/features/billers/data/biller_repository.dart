import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_network.dart';
import 'biller.dart';
import 'biller_catalog.dart';
import 'catalog_strings.dart';

abstract interface class BillerRepository {
  Future<BillerCatalog> fetchCatalog(String language);
  Future<List<Biller>> search(String query, String language);
}

class FakeBillerRepository implements BillerRepository {
  FakeBillerRepository(this._network);

  final MockNetwork _network;

  static const _openAmountCategories = {'mobile-prepaid', 'dth', 'fastag'};
  static const _prefixIds = ['national', 'metro', 'city', 'state'];

  static final _catalogs = <String, BillerCatalog>{};

  BillerCatalog _catalogFor(String language) {
    return _catalogs.putIfAbsent(language, () => _buildCatalog(language));
  }

  static BillerCatalog _buildCatalog(String language) {
    final categories = categoryNames.entries
        .map((e) => BillerCategory(id: e.key, name: e.value[language]!))
        .toList();
    final billers = [
      for (final categoryId in categoryNames.keys)
        for (final prefixId in _prefixIds)
          Biller(
            id: '$categoryId-$prefixId',
            categoryId: categoryId,
            name: billerName(prefixId, categoryId, language),
            mode: _openAmountCategories.contains(categoryId)
                ? BillerMode.openAmount
                : BillerMode.presentment,
            inputParams: _paramsFor(categoryId, language),
          ),
    ];
    return BillerCatalog(categories: categories, billers: billers);
  }

  static List<BillerInputParam> _paramsFor(String categoryId, String language) {
    if (categoryId == 'credit-card') {
      return [
        BillerInputParam(
          key: 'card',
          label: paramLabels['Card Number']![language]!,
          hint: paramHints['Last 4 digits']![language]!,
        ),
        BillerInputParam(
          key: 'mobile',
          label: paramLabels['Registered Mobile']![language]!,
          hint: paramHints['10-digit mobile']![language]!,
        ),
      ];
    }
    final labelKey = switch (categoryId) {
      'mobile-postpaid' || 'mobile-prepaid' => 'Mobile Number',
      'dth' => 'Subscriber ID',
      'fastag' => 'Vehicle Number',
      'lpg' => 'LPG ID',
      'insurance' => 'Policy Number',
      'loan-emi' => 'Loan Account Number',
      'education' => 'Student ID',
      _ => 'Consumer Number',
    };
    final label = paramLabels[labelKey]![language]!;
    return [
      BillerInputParam(
        key: 'account',
        label: label,
        hint: enterHint(label, language),
      ),
    ];
  }

  @override
  Future<BillerCatalog> fetchCatalog(String language) async {
    await _network.delay();
    return _catalogFor(language);
  }

  @override
  Future<List<Biller>> search(String query, String language) async {
    await _network.delay();
    final needle = query.trim().toLowerCase();
    return _catalogFor(language)
        .billers
        .where((b) => b.name.toLowerCase().contains(needle))
        .toList();
  }
}

final billerRepositoryProvider = Provider<BillerRepository>(
  (ref) => FakeBillerRepository(ref.watch(mockNetworkProvider)),
);

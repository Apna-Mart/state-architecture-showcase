import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/format/formats.dart';
import '../../../core/time/clock.dart';
import '../../billers/data/biller.dart';
import '../../billers/data/biller_catalog.dart';
import '../../billers/data/biller_catalog_provider.dart';
import '../../bills/data/due_bills_provider.dart';
import '../../bills/data/fetched_bill.dart';
import '../../saved_billers/data/saved_biller.dart';
import '../../saved_billers/data/saved_billers_provider.dart';
import 'category_icons.dart';
import 'home_screen_data.dart';

final homeCategoriesProvider = Provider.autoDispose<HomeCategoriesData>(
    (ref) => _categories(ref.watch(billerCatalogProvider)));

final homeSavedBillersProvider = Provider.autoDispose<HomeSavedBillersData>(
    (ref) => _savedBillers(
        ref.watch(billerCatalogProvider), ref.watch(savedBillersProvider).items));

final homeRemindersProvider =
    Provider.autoDispose<HomeRemindersData>((ref) => _reminders(
          ref.watch(billerCatalogProvider),
          ref.watch(dueBillsProvider),
          ref.watch(savedBillersProvider).items,
          ref.read(clockProvider)(),
        ));

final homeScreenDataProvider = Provider.autoDispose<HomeScreenData>(
    (ref) => HomeScreenData(
          reminders: ref.watch(homeRemindersProvider),
          savedBillers: ref.watch(homeSavedBillersProvider),
          categories: ref.watch(homeCategoriesProvider),
        ));

HomeCategoriesData _categories(AsyncValue<BillerCatalog> catalogAsync) {
  return switch (catalogAsync) {
    AsyncValue(:final value?) => HomeCategoriesData.loaded([
        for (final c in value.categories)
          CategoryItemData(id: c.id, name: c.name, icon: categoryIcon(c.id)),
      ]),
    AsyncError(:final error) => HomeCategoriesData.error('$error'),
    _ => const HomeCategoriesData.loading(),
  };
}

HomeSavedBillersData _savedBillers(
  AsyncValue<BillerCatalog> catalogAsync,
  List<SavedBiller> saved,
) {
  if (saved.isEmpty) return const HomeSavedBillersData.loaded([]);
  final catalog = catalogAsync.value;
  if (catalog == null) {
    return catalogAsync.hasError
        ? const HomeSavedBillersData.loaded([])
        : const HomeSavedBillersData.loading();
  }
  final byId = {for (final b in catalog.billers) b.id: b};
  return HomeSavedBillersData.loaded([
    for (final s in saved)
      SavedBillerItemData(
        billerId: s.billerId,
        account: s.account,
        nickname: s.nickname,
        billerName: byId[s.billerId]?.name ?? s.billerId,
        openAmount: byId[s.billerId]?.mode == BillerMode.openAmount,
      ),
  ]);
}

HomeRemindersData _reminders(
  AsyncValue<BillerCatalog> catalogAsync,
  AsyncValue<List<FetchedBill>> dueBillsAsync,
  List<SavedBiller> saved,
  DateTime now,
) {
  if (saved.isEmpty) return const HomeRemindersData.loaded([]);
  final catalog = catalogAsync.value;
  if (catalog == null) {
    return catalogAsync.hasError
        ? const HomeRemindersData.loaded([])
        : const HomeRemindersData.loading();
  }
  return switch (dueBillsAsync) {
    AsyncValue(:final value?) =>
      HomeRemindersData.loaded(_dueItems(catalog, value, now)),
    AsyncError() => const HomeRemindersData.loaded([]),
    _ => const HomeRemindersData.loading(),
  };
}

List<DueBillItemData> _dueItems(
  BillerCatalog catalog,
  List<FetchedBill> dueBills,
  DateTime now,
) {
  final byId = {for (final b in catalog.billers) b.id: b};
  return [
    for (final bill in dueBills)
      if (byId[bill.billerId]?.mode == BillerMode.presentment)
        DueBillItemData(
          billerId: bill.billerId,
          account: bill.account,
          billerName: byId[bill.billerId]!.name,
          amountPaise: bill.amountPaise,
          dueInDays: daysUntilDue(bill.dueDate, now),
        ),
  ];
}

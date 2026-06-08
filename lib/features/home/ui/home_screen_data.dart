import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_data.freezed.dart';

@freezed
abstract class CategoryItemData with _$CategoryItemData {
  const factory CategoryItemData({
    required String id,
    required String name,
    required IconData icon,
  }) = _CategoryItemData;
}

@freezed
abstract class DueBillItemData with _$DueBillItemData {
  const factory DueBillItemData({
    required String billerId,
    required String account,
    required String billerName,
    required int amountPaise,
    required int dueInDays,
  }) = _DueBillItemData;
}

@freezed
abstract class SavedBillerItemData with _$SavedBillerItemData {
  const factory SavedBillerItemData({
    required String billerId,
    required String account,
    required String nickname,
    required String billerName,
    required bool openAmount,
  }) = _SavedBillerItemData;
}

@freezed
sealed class HomeRemindersData with _$HomeRemindersData {
  const factory HomeRemindersData.loading() = HomeRemindersLoading;
  const factory HomeRemindersData.loaded(List<DueBillItemData> items) =
      HomeRemindersLoaded;
}

@freezed
sealed class HomeSavedBillersData with _$HomeSavedBillersData {
  const factory HomeSavedBillersData.loading() = HomeSavedBillersLoading;
  const factory HomeSavedBillersData.loaded(List<SavedBillerItemData> items) =
      HomeSavedBillersLoaded;
}

@freezed
sealed class HomeCategoriesData with _$HomeCategoriesData {
  const factory HomeCategoriesData.loading() = HomeCategoriesLoading;
  const factory HomeCategoriesData.error(String message) = HomeCategoriesError;
  const factory HomeCategoriesData.loaded(List<CategoryItemData> items) =
      HomeCategoriesLoaded;
}

@freezed
abstract class HomeScreenData with _$HomeScreenData {
  const factory HomeScreenData({
    required HomeRemindersData reminders,
    required HomeSavedBillersData savedBillers,
    required HomeCategoriesData categories,
  }) = _HomeScreenData;
}

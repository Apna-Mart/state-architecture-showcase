import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_biller.freezed.dart';

@freezed
abstract class SavedBiller with _$SavedBiller {
  const factory SavedBiller({
    required String billerId,
    required String account,
    required String nickname,
  }) = _SavedBiller;
}

@freezed
abstract class SavedBillers with _$SavedBillers {
  const SavedBillers._();

  const factory SavedBillers({required List<SavedBiller> items}) =
      _SavedBillers;

  factory SavedBillers.empty() => const SavedBillers(items: []);

  bool contains(String billerId, String account) => items
      .any((s) => s.billerId == billerId && s.account == account);

  SavedBillers adding(SavedBiller saved) =>
      SavedBillers(items: [...items, saved]);

  SavedBillers removing(String billerId, String account) => SavedBillers(
      items: items
          .where((s) => s.billerId != billerId || s.account != account)
          .toList());
}

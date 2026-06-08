import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/key_value_store.dart';
import 'saved_biller.dart';

abstract interface class SavedBillersRepository {
  SavedBillers restore(String userId);
  Future<void> persist(String userId, SavedBillers value);
}

class StoredSavedBillersRepository implements SavedBillersRepository {
  StoredSavedBillersRepository(this._store);

  final KeyValueStore _store;

  static String _keyFor(String userId) => 'savedBillers.$userId';

  @override
  SavedBillers restore(String userId) {
    final raw = _store.read(_keyFor(userId));
    if (raw == null) return SavedBillers.empty();
    final decoded = jsonDecode(raw) as List<dynamic>;
    return SavedBillers(items: [
      for (final entry in decoded.cast<Map<String, dynamic>>())
        SavedBiller(
          billerId: entry['billerId'] as String,
          account: entry['account'] as String,
          nickname: entry['nickname'] as String,
        ),
    ]);
  }

  @override
  Future<void> persist(String userId, SavedBillers value) =>
      _store.write(_keyFor(userId), jsonEncode([
        for (final s in value.items)
          {
            'billerId': s.billerId,
            'account': s.account,
            'nickname': s.nickname,
          },
      ]));
}

final savedBillersRepositoryProvider = Provider<SavedBillersRepository>(
  (ref) => StoredSavedBillersRepository(ref.watch(keyValueStoreProvider)),
);

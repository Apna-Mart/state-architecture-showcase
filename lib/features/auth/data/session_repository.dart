import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/key_value_store.dart';

abstract interface class SessionRepository {
  ({String userId, String phone})? restore();
  Future<void> save(String userId, String phone);
  Future<void> clear();
}

class StoredSessionRepository implements SessionRepository {
  StoredSessionRepository(this._store);

  final KeyValueStore _store;

  static const _userIdKey = 'session.userId';
  static const _phoneKey = 'session.phone';

  @override
  ({String userId, String phone})? restore() {
    final userId = _store.read(_userIdKey);
    final phone = _store.read(_phoneKey);
    if (userId == null || phone == null) return null;
    return (userId: userId, phone: phone);
  }

  @override
  Future<void> save(String userId, String phone) async {
    await _store.write(_userIdKey, userId);
    await _store.write(_phoneKey, phone);
  }

  @override
  Future<void> clear() async {
    await _store.remove(_userIdKey);
    await _store.remove(_phoneKey);
  }
}

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => StoredSessionRepository(ref.watch(keyValueStoreProvider)),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/event/ui_event.dart';
import '../../auth/data/auth_provider.dart';
import 'saved_biller.dart';
import 'saved_billers_repository.dart';

final savedBillersProvider =
    NotifierProvider<SavedBillersNotifier, SavedBillers>(
        SavedBillersNotifier.new);

class SavedBillersNotifier extends Notifier<SavedBillers> {
  int _epoch = 0;
  String? _userId;

  @override
  SavedBillers build() {
    _epoch++;
    final userId = ref.watch(authProvider.select((a) => a.userIdOrNull));
    _userId = userId;
    if (userId == null) return SavedBillers.empty();
    return ref.read(savedBillersRepositoryProvider).restore(userId);
  }

  Future<void> save(SavedBiller saved) {
    if (state.contains(saved.billerId, saved.account)) {
      return Future.value();
    }
    return _commit(state.adding(saved));
  }

  Future<void> remove(String billerId, String account) =>
      _commit(state.removing(billerId, account));

  Future<void> _commit(SavedBillers next) async {
    final userId = _userId;
    if (userId == null) return;
    final previous = state;
    final epoch = _epoch;
    state = next;
    try {
      await ref.read(savedBillersRepositoryProvider).persist(userId, next);
    } catch (_) {
      if (epoch != _epoch) return;
      state = previous;
      ref.read(uiEventProvider.notifier).emit(const UiEvent.storageFailed());
    }
  }
}

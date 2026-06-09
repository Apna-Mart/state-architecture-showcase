import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../time/clock.dart';

mixin StaleWhileRevalidate<T> on AsyncNotifier<T> {
  DateTime? _fetchedAt;

  Duration get maxAge;

  void markFetched() => _fetchedAt = ref.read(clockProvider)();

  void refreshIfStale() {
    if (state.isLoading) return;
    final fetchedAt = _fetchedAt;
    if (fetchedAt == null) {
      if (state.hasError) ref.invalidateSelf();
      return;
    }
    final age = ref.read(clockProvider)().difference(fetchedAt);
    if (age < maxAge) return;
    ref.invalidateSelf();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../time/clock.dart';

mixin StaleWhileRevalidate<T> on AsyncNotifier<T> {
  DateTime? _fetchedAt;

  Duration get maxAge;

  void markFetched() => _fetchedAt = ref.read(clockProvider)();

  void refreshIfStale() {
    final fetchedAt = _fetchedAt;
    if (fetchedAt == null || state.isLoading) return;
    final age = ref.read(clockProvider)().difference(fetchedAt);
    if (age < maxAge) return;
    ref.invalidateSelf();
  }
}

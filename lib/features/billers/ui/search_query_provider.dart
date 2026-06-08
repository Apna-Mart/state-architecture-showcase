import 'package:flutter_riverpod/flutter_riverpod.dart';

final billerSearchQueryProvider =
    NotifierProvider.autoDispose<BillerSearchQueryNotifier, String>(
        BillerSearchQueryNotifier.new);

class BillerSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void edit(String value) => state = value;
}

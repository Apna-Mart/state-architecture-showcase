import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/auth_provider.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/billers/ui/category_screen.dart';
import '../../features/billers/ui/search_screen.dart';
import '../../features/bills/ui/bill_fetch_screen.dart';
import '../../features/bills/ui/bill_review_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/payments/ui/history_screen.dart';
import '../../features/payments/ui/receipt_screen.dart';
import '../../features/settings/ui/settings_screen.dart';

class AuthListenable extends ChangeNotifier {
  AuthListenable(Ref ref) {
    ref.listen(
        authProvider.select((a) => a.userIdOrNull), (_, _) => notifyListeners());
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final listenable = AuthListenable(ref);
  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) {
      final authed = ref.read(authProvider).userIdOrNull != null;
      final onLogin = state.matchedLocation == '/login';
      if (!authed && !onLogin) return '/login';
      if (authed && onLogin) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: '/',
        builder: (_, _) => const HomeScreen(),
        routes: [
          GoRoute(path: 'search', builder: (_, _) => const SearchScreen()),
          GoRoute(path: 'history', builder: (_, _) => const HistoryScreen()),
          GoRoute(path: 'settings', builder: (_, _) => const SettingsScreen()),
          GoRoute(
            path: 'category/:categoryId',
            builder: (_, state) =>
                CategoryScreen(categoryId: state.pathParameters['categoryId']!),
          ),
          GoRoute(
            path: 'biller/:billerId',
            builder: (_, state) =>
                BillFetchScreen(billerId: state.pathParameters['billerId']!),
            routes: [
              GoRoute(
                path: 'review',
                builder: (_, state) => BillReviewScreen(
                  billerId: state.pathParameters['billerId']!,
                  account: state.uri.queryParameters['account'] ?? '',
                  amountPaise:
                      int.tryParse(state.uri.queryParameters['amount'] ?? ''),
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'payment/:paymentId',
            builder: (_, state) =>
                ReceiptScreen(paymentId: state.pathParameters['paymentId']!),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  ref.onDispose(listenable.dispose);
  return router;
});

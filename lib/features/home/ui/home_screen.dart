import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/format/formats.dart';
import '../../../l10n/l10n.dart';
import '../../auth/data/auth_provider.dart';
import '../../billers/data/biller_catalog_provider.dart';
import 'home_screen_data.dart';
import 'home_screen_data_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(ref.l10n.appTitle),
            floating: true,
            actions: [
              IconButton(
                  onPressed: () => context.go('/search'),
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () => context.go('/history'),
                  icon: const Icon(Icons.receipt_long)),
              IconButton(
                  onPressed: () => context.go('/settings'),
                  icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () => ref.read(authProvider.notifier).logout(),
                  icon: const Icon(Icons.logout)),
            ],
          ),
          const _RemindersSection(),
          const _SavedBillersSection(),
          const _CategoriesSection(),
        ],
      ),
    );
  }
}

class _RemindersSection extends ConsumerWidget {
  const _RemindersSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(homeRemindersProvider);
    return switch (reminders) {
      HomeRemindersLoading() => SliverMainAxisGroup(slivers: [
          _SectionTitle(ref.l10n.upcomingBills),
          const SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(),
              ),
            ),
          ),
        ]),
      HomeRemindersLoaded(:final items) when items.isEmpty =>
        const SliverToBoxAdapter(child: SizedBox.shrink()),
      HomeRemindersLoaded(:final items) => SliverMainAxisGroup(slivers: [
          _SectionTitle(ref.l10n.upcomingBills),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 160,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    _DueBillCard(item: items[index]),
              ),
            ),
          ),
        ]),
    };
  }
}

class _SavedBillersSection extends ConsumerWidget {
  const _SavedBillersSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedBillers = ref.watch(homeSavedBillersProvider);
    return switch (savedBillers) {
      HomeSavedBillersLoading() => SliverMainAxisGroup(slivers: [
          _SectionTitle(ref.l10n.savedBillers),
          const SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(),
              ),
            ),
          ),
        ]),
      HomeSavedBillersLoaded(:final items) when items.isEmpty =>
        const SliverToBoxAdapter(child: SizedBox.shrink()),
      HomeSavedBillersLoaded(:final items) => SliverMainAxisGroup(slivers: [
          _SectionTitle(ref.l10n.savedBillers),
          SliverFixedExtentList.builder(
            itemExtent: 72,
            itemCount: items.length,
            itemBuilder: (context, index) =>
                _SavedBillerTile(item: items[index]),
          ),
        ]),
    };
  }
}

class _CategoriesSection extends ConsumerWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(homeCategoriesProvider);
    return switch (categories) {
      HomeCategoriesLoading() => const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      HomeCategoriesError() => const SliverFillRemaining(
          hasScrollBody: false,
          child: _ErrorRetry(),
        ),
      HomeCategoriesLoaded(:final items) => SliverMainAxisGroup(slivers: [
          _SectionTitle(ref.l10n.payABill),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _CategoryTile(item: items[index]),
                childCount: items.length,
              ),
            ),
          ),
        ]),
    };
  }
}

class _ErrorRetry extends ConsumerWidget {
  const _ErrorRetry();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ref.l10n.somethingWentWrong),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => ref.invalidate(billerCatalogProvider),
            child: Text(ref.l10n.retry),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}

class _DueBillCard extends ConsumerWidget {
  const _DueBillCard({required this.item});

  final DueBillItemData item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        onTap: () => context.go(
            '/biller/${item.billerId}/review?account=${Uri.encodeQueryComponent(item.account)}'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.billerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium),
              Text(formatPaise(item.amountPaise, ref.languageCode),
                  style: Theme.of(context).textTheme.titleMedium),
              Text(dueLabel(ref.l10n, item.dueInDays),
                  style: TextStyle(
                      color: item.dueInDays < 0
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.secondary)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavedBillerTile extends StatelessWidget {
  const _SavedBillerTile({required this.item});

  final SavedBillerItemData item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.bookmark),
      title: Text(item.nickname),
      subtitle: Text('${item.billerName} · ${item.account}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go(item.openAmount
          ? '/biller/${item.billerId}'
          : '/biller/${item.billerId}/review?account=${Uri.encodeQueryComponent(item.account)}'),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.item});

  final CategoryItemData item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.go('/category/${item.id}'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 28),
            const SizedBox(height: 8),
            Text(item.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

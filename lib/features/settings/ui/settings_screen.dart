import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../data/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(ref.l10n.settings)),
      body: ListView(
        children: [
          _SectionTitle(title: ref.l10n.language),
          const _LanguageOptions(),
          _SectionTitle(title: ref.l10n.theme),
          const _ThemeSelector(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _LanguageOptions extends ConsumerWidget {
  const _LanguageOptions();

  static const _languages = [
    (locale: Locale('en'), name: 'English'),
    (locale: Locale('hi'), name: 'हिन्दी'),
    (locale: Locale('ar'), name: 'العربية'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected =
        ref.watch(settingsProvider.select((s) => s.localeOverride));
    return Column(
      children: [
        _LanguageTile(
          name: ref.l10n.systemDefault,
          selected: selected == null,
          onTap: () => ref.read(settingsProvider.notifier).setLocale(null),
        ),
        for (final language in _languages)
          _LanguageTile(
            name: language.name,
            selected: selected == language.locale,
            onTap: () =>
                ref.read(settingsProvider.notifier).setLocale(language.locale),
          ),
      ],
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: selected ? const Icon(Icons.check) : null,
      onTap: onTap,
    );
  }
}

class _ThemeSelector extends ConsumerWidget {
  const _ThemeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(settingsProvider.select((s) => s.themeMode));
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SegmentedButton<ThemeMode>(
        segments: [
          ButtonSegment(
              value: ThemeMode.system,
              label: Text(ref.l10n.systemDefault)),
          ButtonSegment(
              value: ThemeMode.light, label: Text(ref.l10n.themeLight)),
          ButtonSegment(
              value: ThemeMode.dark, label: Text(ref.l10n.themeDark)),
        ],
        selected: {mode},
        onSelectionChanged: (selection) => ref
            .read(settingsProvider.notifier)
            .setThemeMode(selection.single),
      ),
    );
  }
}

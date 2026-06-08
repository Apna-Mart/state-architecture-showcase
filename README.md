# Bill Payments — Flutter / Riverpod

Flutter implementation of the bill-payments state-architecture showcase (Jetpack Compose port lives on branch `android-compose`).

Phone-OTP login (any 10 digits, any 6-digit OTP), localized biller catalog (en/hi/ar with RTL), bill fetch and review, payments with history and receipts, saved billers with due-bill reminders, persisted theme and language. All data is fake — a seeded `MockNetwork` simulates latency and declines every 10th payment.

## Stack

Flutter · Riverpod 3 (manual providers, no codegen) · freezed sealed unions · GoRouter · intl

## Build & Test

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

## Run

```bash
flutter run
```

# Architecture

Riverpod 3 showcase. Every rule below is enforced by convention, lint, or test — copy the patterns, keep the rules.

## Layers

```
Repository (interface + impl)   →  owns I/O. No Riverpod types inside classes.
Data provider (keepAlive)       →  app facts: auth, payments, savedBillers, billerCatalog.
Derived provider (autoDispose)  →  per-screen projection: *ScreenData unions, form inputs.
Widget (ConsumerWidget)         →  dumb. Watches one projection, dispatches to notifiers.
```

Dependency direction: `ui → data → core`. Feature `ui` never imports another feature's `ui`. Cross-feature `data → data` watching is allowed (e.g. `dueBillsProvider` watches `savedBillersProvider`).

## Lifetime rule

- **keepAlive** (`NotifierProvider` / `AsyncNotifierProvider`): facts that outlive any screen.
- **autoDispose**: everything derived or screen-local. Family params make instances per-argument; stale instances die with their listeners (this is also how search debouncing works — see `biller_search_results_provider.dart`).

## State shape

- Every multi-phase state is a **freezed sealed union** (`Auth`, `*ScreenData`). No bool soups.
- Notifiers gate **transitions**, not just states: `if (current is! OtpSent) return;`.
- Validation is **derived** in projections, never stored (`loginScreenDataProvider`).
- Store minimal facts; projections compute the rest each build.

## AsyncValue projection canon

One way only. Handle **all three** cases; never read `.value` and treat null as loading:

```dart
final asyncValue = ref.watch(someAsyncProvider);
if (asyncValue case AsyncError(:final error)) return Data.error('$error');
final value = asyncValue.value;
if (value == null) return const Data.loading();
```

(or a full `switch` over `AsyncData/AsyncError/_`). `.value`-with-null-check alone swallows errors into infinite loading.

## Rebuild isolation

- One projection provider per screen **section** when inputs differ (`homeCategoriesProvider` vs `homeRemindersProvider`) — a section recomputes only when its own inputs emit.
- Leaf widgets use `.select()` when watching a state they need a slice of.
- Sub-widgets are real `StatelessWidget`/`ConsumerWidget` classes, never helper methods.
- Isolation is **tested by counting notifications** (`rebuild_isolation_test.dart`).

## Errors and events

- Repos throw typed exceptions (`InvalidOtpException`); notifiers map them to state + events.
- **Every caught failure emits a `UiEvent`** — no silent catch blocks.
- `UiEvent` is a one-shot queue consumed by `App` via `ref.listen`; events are not state and never replay on rebuild.

## Persistence

- All storage behind `KeyValueStore`; keys scoped per user (`payments.$userId`).
- Restore is synchronous in `build()` — no loading flash for local data.
- Two write strategies, chosen by data class:
  - **Money records** (`PaymentsNotifier`): write-through via `listenSelf`, failures emit `storageFailed`, record is NEVER rolled back.
  - **Preferences** (`SavedBillersNotifier`): optimistic update, await persist, **rollback + event** on failure.
- In-flight async guarded by an **epoch counter** bumped in `build()` — a user switch mid-operation discards stale completions.
- Interrupted `processing` payments are restored as `failed` (repository decode rule).

## Server-cache policy

- `StaleWhileRevalidate` mixin: per-notifier `maxAge`, `refreshIfStale()` called on app resume (`AppLifecycleListener` in `app.dart`).
- **Mutations own their invalidations**: a write method invalidates every fetch provider its server change stales (`pay()` → `ref.invalidate(dueBillsProvider)`).
- Riverpod 3 auto-retries failed providers; tests asserting error states must pass `retry: (_, _) => null` to the container.

## Time

`DateTime.now()` is banned outside `clockProvider`. Inject the clock; tests override it (`stale_while_revalidate_test.dart`).

## Localization

- `l10nProvider` is the only string/locale source for app code: `(locale, strings)` derived from `settingsProvider.localeOverride` + reactive `platformLocaleProvider`. `context.l10n` does not exist.
- `ref.l10n` / `ref.languageCode` (extension) are **build-only** — they `watch`. In callbacks use `ref.read(l10nProvider).strings`.
- Locale resolution lives ONLY in `l10nProvider`. Never add `localeResolutionCallback` to `MaterialApp`.
- Per-locale formatting facts (number locale, date locale, currency symbol) live in one table: `localeConfigs` (`core/format/locale_config.dart`). Adding a language = ARB file + one config row; `l10n_guard_test.dart` fails if they diverge.
- Currency symbol is a property of the money, not the viewer's language — locale only shapes digits and dates.

## Routing

- Router is a provider (`appRouterProvider`) — no globals, no init order.
- Auth redirect derives from `authProvider` via `refreshListenable`. Navigation reacts to state; screens never imperatively navigate on auth changes.

## Testing

- No mocking libraries. `ProviderContainer` + overrides + `InMemoryKeyValueStore` (or a throwing subclass for failure paths).
- Notifier logic tested headless via `container.read/listen/pump`; widgets get smoke tests only.
- Every architectural guarantee has a test: isolation (notification counts), persistence (fresh container restore), recovery (interrupted payment), rollback (failing store), staleness (fake clock).

## Lint

`riverpod_lint` runs as a native analyzer plugin (see `analysis_options.yaml`). `dart analyze` must be clean.

## License

[MIT](LICENSE) © ApnaMart

# Bill Payments — Jetpack Compose

Jetpack Compose implementation of the bill-payments state-architecture showcase (Flutter/Riverpod original lives on branch `flutter-riverpod`).

Phone-OTP login (any 10 digits, any 6-digit OTP), localized biller catalog (en/hi/ar with RTL), bill fetch and review, payments with history and receipts, saved billers with due-bill reminders, persisted theme and language. All data is fake — a seeded `MockNetwork` simulates latency and declines every 10th payment.

## Stack

Kotlin 2.4 · Compose (BOM 2026.05) · Hilt · Navigation 3 · kotlinx-serialization · minSdk 26

## Build & Test

```bash
./gradlew :app:assembleDebug
./gradlew :app:testDebugUnitTest
```

## Run

```bash
android emulator start <avd>
android run --apks app/build/outputs/apk/debug/app-debug.apk
```

# Architecture

Jetpack Compose port of the Flutter/Riverpod bill-payments showcase (branch `flutter-riverpod`). Every Riverpod rule has a mechanical Kotlin counterpart; layering, persistence strategy, and testing stance carry over intact.

## Two Layers

```
UI (dumb composables: ScreenData in, callbacks out)
  ↑ collects
Projection layer — @HiltViewModel
  combine(store flows, input flows) → StateFlow<ScreenData>
  stateIn(viewModelScope, WhileSubscribed(5_000), initial)
  ↑ observes
Data layer — @Singleton stores
  MutableStateFlow + transition-gated methods, sync restore in init
  ↑ reads
Repository interface → Fake implementation (no DI types inside)
```

| Riverpod | This codebase |
|---|---|
| `NotifierProvider` / `AsyncNotifierProvider` (keepAlive) | `@Singleton` store: `MutableStateFlow<T>` + gated methods |
| `Provider.autoDispose` projection | `@HiltViewModel` + `combine(...).stateIn(WhileSubscribed(5_000))` |
| `NotifierProvider.autoDispose` inputs | `SavedStateHandle.getStateFlow` fields inside the screen ViewModel |
| `.family` | assisted-injected ViewModel (`@HiltViewModel(assistedFactory = ...)`) keyed by Nav3 entry args |
| freezed sealed union | Kotlin `sealed interface` + `data class`/`data object` |
| `AsyncValue<T>` | `core/async/Async<T>`: `Loading`, `Data`, `Error` |
| `.select()` rebuild isolation | per-section `StateFlow` + value-equal conflation + Compose skipping |
| `uiEventProvider` | `@Singleton UiEventBus` (`Channel(BUFFERED)`), collected once in `MainActivity` |
| GoRouter provider + auth redirect | `@Singleton Navigator` owning `SnapshotStateList<NavKey>`, auth gate in `MainActivity` |
| `clockProvider` / `keyValueStoreProvider` / `mockNetworkProvider` | injected `Clock` fun interface / `KeyValueStore` / `MockNetwork` |
| `StaleWhileRevalidate` mixin | `core/cache/Freshness` composed into stores |
| ARB l10n + `l10nProvider` | `values{,-hi,-ar}/strings.xml` + `AppCompatDelegate.setApplicationLocales` |
| `ProviderContainer` tests | plain-constructor stores + fakes + Turbine + virtual time |

## Lifetime Rules

- Process-wide facts (auth, catalog, due bills, payments, saved billers, settings) are `@Singleton` stores. Restore happens synchronously in `init {}` from `KeyValueStore` — no loading flash for local data.
- Screen projections live in ViewModels scoped to Nav3 entries via `ViewModelStoreNavEntryDecorator`; pop = clear. `WhileSubscribed(5_000)` stops upstream work when nobody looks — the autoDispose analogue.
- Form inputs are `SavedStateHandle.getStateFlow` fields co-located with their screen's projection; text fields render projection state (no `rememberSaveable` copies), validation is derived in `combine`, never stored.

## State Shape

- Every multi-phase state is a sealed interface (`Auth`, `*ScreenData`). No `isLoading`/`isError` boolean pairs anywhere.
- Stores gate transitions (`if (state.value !is OtpSent) return`).
- Async facts are `StateFlow<Async<T>>`; projections exhaust `Loading`/`Data`/`Error` via `when`.

## Persistence

- **Money records (`PaymentsStore`)** — write-through: the store collects its own flow and persists every change; failure emits `UiEvent.StorageFailed`; records are never rolled back. Interrupted `Processing` payments decode as `Failed` on restore.
- **Preferences (`SavedBillersStore`)** — optimistic + rollback: state updates immediately, persist runs async, failure restores the previous value and emits `StorageFailed`.
- **Epoch counter** — per-user stores bump an epoch on user switch; in-flight coroutines compare epochs before applying results, so a logout mid-payment discards the stale completion.
- **Key scoping** — per-user: `payments.$userId`, `savedBillers.$userId`, `session.userId`, `session.phone`; app-global: `settings.locale`, `settings.themeMode`.

## Stale-While-Revalidate

`Freshness(clock, maxAge)` tracks `markFetched()`/`isStale()`. Catalog maxAge 30 min, due bills 5 min. `MainActivity`'s `LifecycleResumeEffect` calls `refreshIfStale()` on both; a successful payment calls `dueBillsStore.invalidate()`. `DateStream` ticks the local date across midnight so due-day labels re-project without a store emission.

## Events & Errors

- Repositories throw typed exceptions (`InvalidOtpException`, `MockPaymentDeclined`, `StorageException`).
- Stores map exceptions to state + emit a `UiEvent` — every caught failure emits, no silent catches.
- `MainActivity` is the single event consumer: `PaymentStarted` rewrites the back stack to `[Home, Receipt(id)]`; everything else is a localized snackbar.

## Navigation

- Route keys are `@Serializable` classes in `core/nav/NavKeys.kt`; all navigation state lives in keys, no side channels.
- `Navigator` owns the back stack; auth gate observes `AuthStore` — unauthenticated resets to `[Login]`, authentication on the login screen resets to `[Home]`.
- Back stack survives process death: `MainActivity` serializes it to instance state via `Navigator.serialized()`/`restore()` (kotlinx-serialization over the sealed key hierarchy).

## Dependency Direction

`ui → data → core`. Feature `ui` never imports another feature's `ui`. Cross-feature `data → data` is allowed (`DueBillsStore` observes `SavedBillersStore`; `PaymentsStore` invalidates `DueBillsStore`).

## Testing (No Mock Libraries)

- Fakes only: `InMemoryKeyValueStore` (with `failWrites` knob), `Fake*Repository`, fixed `Clock`, seeded `MockNetwork`.
- Store scope under test: `CoroutineScope(SupervisorJob() + StandardTestDispatcher(testScheduler))` — note `runTest`'s `backgroundScope` is NOT pumped by `advanceUntilIdle`.
- ViewModel tests set a `MainDispatcherRule` and collect with Turbine.
- Coverage: transition gating, persistence restore across fresh store graphs, optimistic rollback, SWR with controllable clock, epoch discard on user switch, emission isolation (home sections), l10n key-set guard, Robolectric Hilt smoke test.

## No Comments

Source files contain zero comments by design; names carry the intent.

## License

[MIT](LICENSE) © ApnaMart

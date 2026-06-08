# Bill Payments — SwiftUI

SwiftUI implementation of the bill-payments state-architecture showcase (Flutter/Riverpod original lives on branch `flutter-riverpod`).

Phone-OTP login (any 10 digits, any 6-digit OTP), localized biller catalog (en/hi/ar with RTL), bill fetch and review, payments with history and receipts, saved billers with due-bill reminders, persisted theme. All data is fake — a seeded `MockNetwork` simulates latency and declines every 10th payment.

## Stack

Swift 6 (Xcode 26.5 toolchain) · SwiftUI + Observation · Swift Testing · XcodeGen 2.45.4 · zero third-party dependencies · iOS 26 · `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`

## Build & Test

```bash
brew install xcodegen
xcodegen
xcodebuild -project BillPayments.xcodeproj -scheme BillPayments -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
xcodebuild -project BillPayments.xcodeproj -scheme BillPayments -destination 'platform=iOS Simulator,name=iPhone 17 Pro' test
```

## Run

```bash
open BillPayments.xcodeproj   # then ⌘R in Xcode
```

or headless to a booted simulator:

```bash
xcodebuild -project BillPayments.xcodeproj -scheme BillPayments -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

# Architecture

SwiftUI port of the Flutter/Riverpod bill-payments showcase (branch `flutter-riverpod`). Every Riverpod rule has a mechanical Swift/Observation counterpart; layering, persistence strategy, and testing stance carry over intact.

## Two Layers

```
UI (dumb views: ScreenData in, callbacks out)
  ↑ reads
Projection layer — @Observable ScreenModel held by @State
  ScreenData enum derived as a computed property over store state + inputs
  pop = view drop = ScreenModel deinit (autoDispose analogue)
  ↑ observes
Data layer — @Observable singleton stores
  private(set) state + transition-gated methods, sync restore in init
  ↑ reads
Repository protocol → Fake implementation (no DI types inside)
```

| Riverpod | This codebase |
|---|---|
| `NotifierProvider` / `AsyncNotifierProvider` (keepAlive) | `@Observable final class` store: `private(set) var state` + gated methods, built once in `AppContainer` |
| `Provider.autoDispose` projection | `@State` `@Observable` `ScreenModel` deriving `ScreenData` as a computed property |
| `NotifierProvider.autoDispose` inputs | stored `var` fields on the `ScreenModel` |
| `.family` | `init(args:)` — `ScreenModel` constructed from route values |
| freezed sealed union | Swift `enum` with associated values |
| `AsyncValue<T>` | `Core/Async<T>`: `loading`, `data`, `error` |
| `.select()` rebuild isolation | Observation field-level tracking + SwiftUI view diffing |
| `uiEventProvider` | `UiEventBus` (`AsyncStream`), consumed once in `RootView` `.task` |
| GoRouter provider + auth redirect | `Router` `@Observable [Route]` + `NavigationStack`, auth gate in `RootView` |
| `clockProvider` / `keyValueStoreProvider` / `mockNetworkProvider` | `Clock` / `KeyValueStore` / `MockNetwork` protocols injected via `AppContainer` |
| `StaleWhileRevalidate` mixin | `Core/Freshness` composed into stores |
| ARB l10n + `l10nProvider` | `Localizable.xcstrings` (en/hi/ar), automatic RTL via `layoutDirection` environment |
| `ProviderContainer` tests | plain-init stores + fakes + Swift Testing |

## Lifetime Rules

- Process-wide facts (auth, catalog, due bills, payments, saved billers, settings) are `@Observable` stores built once in `AppContainer` and held for the app's lifetime. Restore happens synchronously in `init` from `KeyValueStore` — no loading flash for local data.
- Screen projections are `@Observable` `ScreenModel`s held by `@State` on their view; the view drops on pop and the `ScreenModel` deinits — the autoDispose analogue. A view's `.task` is cancelled on disappear, stopping `AsyncStream` consumption — the `WhileSubscribed` analogue.
- Form inputs are stored `var` fields on the screen's `ScreenModel` (e.g. `LoginScreenModel.phone`/`otp`). Text fields bind to those fields via `@Bindable`; validation is derived in the `ScreenData` computed property, never stored.

## State Shape

- Every multi-phase state is an `enum` (`Auth`, `*ScreenData`). No `isLoading`/`isError` boolean pairs anywhere.
- Stores gate transitions (`guard case .otpSent = state else { return }`).
- Async facts are `Async<T>`; projections exhaust `loading`/`data`/`error` via `switch`.

## Persistence

- **Money records (`PaymentsStore`)** — write-through: the store persists on every state change; failure emits `UiEvent.storageFailed`; records are never rolled back. Interrupted `processing` payments decode as `failed` on restore (`StoredPaymentHistoryRepository.decode`).
- **Preferences (`SavedBillersStore`)** — optimistic + rollback: state updates immediately, persist runs in an unstructured `Task`, failure restores the previous value and emits `storageFailed`.
- **Settings (`SettingsStore`)** — fire-and-forget: theme writes through `Task { try? await ... }` with no rollback, mirroring the Kotlin branch's settings store.
- **Epoch counter** — per-user stores bump `epoch` on user switch; in-flight tasks compare `startedEpoch != epoch` before applying results, so a logout mid-payment discards the stale completion.
- **Key scoping** — per-user: `payments.<userId>`, `savedBillers.<userId>`, `session.userId`, `session.phone`; app-global: `settings.themeMode`. Language follows the system locale; the in-app picker writes the standard `AppleLanguages` per-app override (iOS analogue of Kotlin's `setApplicationLocales`), applied on next launch — no key in the app's own store.

## Stale-While-Revalidate

`Freshness(clock:maxAge:)` tracks `markFetched()`/`isStale()`. Catalog maxAge 30 min, due bills 5 min. `RootView` handles `scenePhase == .active` by calling `refreshIfStale()` on both stores (and `refreshLanguage()` on settings); a successful payment calls `dueBillsStore.invalidate()` via `onPaymentSucceeded`. `MidnightDateStream` yields the local start-of-day across midnight so due-day labels re-project without a store emission.

## Events & Errors

- Repositories throw typed errors (`InvalidOtpError`, `MockPaymentDeclined`, `StorageError`).
- Stores map errors to state + emit a `UiEvent` — every caught failure emits, no silent catches.
- `RootView` is the single event consumer via one `.task` over `UiEventBus.events`: `paymentStarted` rewrites the stack to `[.receipt(paymentId:)]`; everything else is a localized toast.

## Navigation

- `Route` is a `Codable` `Hashable` enum; all navigation state lives in route values, no side channels.
- `Router` (`@Observable`) owns the path; the auth gate lives in `RootView` above the path — unauthenticated renders `LoginScreen`, authentication swaps to the `NavigationStack` rooted at `HomeScreen`, and an auth change resets the path to `[]`.
- The path survives process death: `RootView` serializes it to `@SceneStorage("navPath")` via `Router.serialized()`/`restore(from:)` (`JSONEncoder`/`JSONDecoder` over the `Codable` route enum).

## Dependency Direction

`UI → Data → Core`. A feature's `UI` never imports another feature's `UI`. Cross-feature `Data → Data` is wired through closures set in `AppContainer` (`SavedBillersStore.onChange` refreshes `DueBillsStore`; `PaymentsStore.onPaymentSucceeded` invalidates `DueBillsStore`) — no store holds a direct reference to a peer it mutates.

## Testing (No Mock Libraries)

- Fakes only: `InMemoryKeyValueStore` (with `failWrites` knob), `Fake*Repository`, `FixedClock`, seeded `MockNetwork`.
- Async is driven by awaiting the store's own task handles (`await store.pendingWork?.value`, `await auth.pendingWork?.value`) instead of pumping a virtual scheduler — this replaces `advanceUntilIdle`.
- Event assertions iterate `bus.events.makeAsyncIterator()` and `await iterator.next()`.
- Coverage: transition gating, persistence restore across fresh store graphs, optimistic rollback, SWR with a controllable `FixedClock`, epoch discard on user switch, emission isolation via `withObservationTracking`, an `xcstrings` key-set guard (`L10nGuardTests`), and an `AppContainer`-shaped smoke test.

## No Comments

Source files contain zero comments by design; names carry the intent.

## License

[MIT](LICENSE) © ApnaMart

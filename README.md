# BillPayments — Expo + Zustand + TanStack Query (Branch B)

A React Native port of the `flutter-riverpod` bill-payments app with exact behavioral parity. The Expo shell uses expo-router; TanStack Query owns all server-derived async data (catalog, due bills, search, bill); Zustand vanilla stores hold long-lived client facts (auth, payments, saved billers, settings, UI events). The Flutter app is the source of truth for every constant, validation rule, state machine, l10n string, and catalog shape.

## Stack

- Expo SDK 56 (React Native 0.85, React 19.2)
- expo-router 56.2.9 (typed routes; no direct `@react-navigation/*` imports)
- TypeScript strict (`noUncheckedIndexedAccess` on)
- zustand 5 (vanilla `createStore` + `useStore` + `useShallow`)
- TanStack Query 5 (`staleTime`, `gcTime`, `focusManager`, `invalidateQueries`)
- react-native-mmkv 4 (Nitro, synchronous reads; dev build only)
- expo-localization, i18next 26 + react-i18next 17 + i18next-icu (ICU MessageFormat plurals)
- jest-expo + @testing-library/react-native 14 (async `render`/`fireEvent`/`renderHook`)

## Build / test / run

```
npm install
npm test
npm run tsc
npx expo run:ios        # dev build — Expo Go unavailable on SDK 56
npx expo run:android
```

Do not run build/install commands concurrently with the sibling `react-native-zustand` worktree — serialize all `npm install` / `npx expo` / `pod install` / `expo run` invocations.

## Architecture rulebook

1. Two layers: long-lived stores hold facts; screen-scoped projection hooks derive sealed `ScreenData` discriminated unions. UI is dumb — data in, callbacks out.
2. Every multi-phase state is a discriminated union (`kind`/`status` literal tag) — no boolean soups. Exhaustive `switch` + `assertNever`.
3. Stores gate transitions (`if (state.kind !== 'otpSent') return`). Validation is derived in projections, never stored.
4. Persistence by intent: money records write-through, never rolled back (interrupted `processing` decodes as `failed`); preferences optimistic with rollback on persist failure. Per-user keys (`payments.$userId`, `savedBillers.$userId`, `session.userId`, `session.phone`), app-global keys (`settings.locale`, `settings.themeMode`). An epoch counter bumped on user switch discards stale async completions.
5. Every caught failure emits a one-shot `UiEvent` — no silent catches. The queue is consumed once at the app root via a token-keyed effect; events never replay.
6. Stale-while-revalidate via TanStack `staleTime` with an injectable `Clock`; refresh on app foreground through `focusManager` wired to `AppState`. Mutations own their invalidations — `pay()` success calls `queryClient.invalidateQueries({ queryKey: ['dueBills'] })`.
7. Router state is typed; the auth gate derives from the auth store (`(app)/_layout` `<Redirect>`) — screens never imperatively navigate on auth changes.
8. `Date.now()` is banned outside the injected `Clock` (`src/core/clock/clock.ts`).
9. Tests use fakes, never mocks: `InMemoryKeyValueStore` (+ `ThrowingWriteStore` subclass), seeded `MockNetwork`, a fixed clock, and jest fake timers; rebuild isolation is verified by counting store subscription notifications.
10. Dependency direction `ui → data → core`; a feature's `ui` never imports another feature's `ui`; cross-feature `data → data` is allowed.

## RTL caveat

`I18nManager.forceRTL` requires an app restart to fully flip layout direction. Switching the language to Arabic flips the flag immediately, but the visual direction change takes effect only after the app is restarted.

## Mapping from flutter-riverpod

| flutter-riverpod | expo-zustand-query |
|---|---|
| keepAlive `NotifierProvider` (auth, payments, savedBillers, settings) | zustand vanilla `createStore` in `AppContainer`; gated methods; sync restore at creation |
| `AsyncNotifierProvider` + `StaleWhileRevalidate` mixin (catalog 30 min, dueBills 5 min) | **TanStack `useQuery` with `staleTime`** — Query *replaces* the hand-rolled SWR mixin entirely |
| `AppLifecycleListener` resume → `refreshIfStale` | **TanStack `focusManager` wired to `AppState`** |
| `ref.invalidate(dueBillsProvider)` in `pay()` | **`queryClient.invalidateQueries({ queryKey: ['dueBills'] })`** from the pay store's `onPaySuccess` |
| `billerSearchResultsProvider.family` + 200ms delay | `useQuery({ queryKey: ['search', language, debounced], enabled: q.length >= 2 })` + `useDebouncedValue` |
| `fetchedBillProvider.family` | `useQuery({ queryKey: ['bill', billerId, account] })` |
| `Provider.autoDispose` projection | projection hook combining query results + `useStore` selectors into a sealed `ScreenData` union |
| `NotifierProvider.autoDispose` inputs | screen-local store via `useState(() => createStore(...))[0]` |
| freezed sealed union | TS discriminated union + `assertNever` |
| `uiEventProvider` | `UiEventQueue` vanilla store; root consumes once via token-keyed effect |
| GoRouter + redirect | expo-router file routes + `(app)/_layout` `<Redirect>` gate from auth store |
| `clockProvider` | injected `Clock` in `createAppContainer(overrides?)`; tests pass fakes |
| `ProviderContainer` tests | headless vanilla stores (`getState`/`subscribe`) + test `QueryClient` (`retry: false`) + jest fake timers |
| user switch (`_epoch`) | epoch counters in per-user stores + `queryClient.clear()` on logout |

## License

[MIT](LICENSE) © ApnaMart

# Bill Payments — React Native + Zustand

Bill payments app — bare React Native 0.85 + TypeScript + Zustand 5 port of the `flutter-riverpod` reference. Same login/OTP flow, 60-biller localized catalog, fetch/review/pay with a deterministic 1-in-10 decline, payment history and receipts, saved billers with due-bill reminders, settings (language + theme), full en/hi/ar localization including Arabic RTL, and the identical state-architecture guarantees.

## Stack

| Concern | Choice |
|---|---|
| Runtime | React Native 0.85.3 / React 19.2 |
| State | Zustand 5.0.14 (`zustand/vanilla` `createStore`, `useStore`, `useShallow` from `zustand/react/shallow`, no equality fn in `create`) |
| Navigation | @react-navigation/native 7.2.5 + native-stack (Static API: `createNativeStackNavigator` / `createStaticNavigation`, `StaticParamList`, auth-gated `if`-groups) |
| Storage | react-native-mmkv 4.3.1 (`createMMKV()`, sync reads) + react-native-nitro-modules |
| i18n | i18next 26.3.1 + react-i18next 17.0.8 + i18next-icu 2.4.3; RTL via `I18nManager` |
| Test | jest + @react-native/jest-preset 0.85.3 + @testing-library/react-native 14.0.0 (async `render` / `fireEvent` / `act` — await them; `react-test-renderer` banned) |
| Node | >= 20.19.4 |

## Build / test / run

```
npm install
npm test            # jest
npx tsc --noEmit    # type check
npm run lint        # eslint
npm run ios         # or: npx react-native run-ios
npm run android     # or: npx react-native run-android
```

Note: install/build commands MUST be serialized with the `expo-zustand-query` worktree — never run two RN/Metro/gradle builds concurrently in sibling worktrees (cache + RAM thrash).

## Architecture rulebook

1. **Two layers.** Long-lived vanilla zustand stores hold facts; screen-scoped projection hooks derive sealed `ScreenData` discriminated unions; UI components are dumb (ScreenData in, callbacks out).
2. **Discriminated unions with `assertNever`.** Every variant carries a `kind` tag; switches are exhaustive. No boolean soups.
3. **Stores gate transitions; validation lives in projections** (10-digit phone, 6-digit OTP, min-2-char search, openAmount amount-required), never stored.
4. **Persistence by intent.** Money records write through and are never rolled back; an interrupted `processing` payment decodes as `failed` on restore. Preferences and saved billers write optimistically with rollback on failure. Keys are per-user (`payments.$userId`, `savedBillers.$userId`) or app-global (`settings.locale`, `settings.themeMode`).
5. **Epoch counters discard stale async** completions on user switch.
6. **One-shot `UiEvent`s.** Every caught failure emits a `UiEvent` consumed exactly once at the app root, never replayed.
7. **Stale-while-revalidate with an injected clock.** Catalog SWR 30 min, due bills SWR 5 min; `refreshIfStale` runs on `AppState` `active`; mutations own their invalidations (`pay()` → dueBills).
8. **Typed router, auth gate from the auth store.** No imperative navigation on auth change — the navigator re-renders its `if`-groups.
9. **`Date.now()` banned outside the injected `Clock`.**
10. **Tests use fakes not mocks.** Dependency direction `ui → data → core`; a feature `ui` never imports another feature's `ui`.

## RTL caveat

Switching to/from Arabic calls `I18nManager.forceRTL`, which requires an app reload to flip layout direction — the change applies after restart.

## Mapping table (flutter-riverpod → React Native + Zustand)

| flutter-riverpod | React Native + Zustand |
|---|---|
| keepAlive `NotifierProvider` / `AsyncNotifierProvider` | vanilla `createStore` singleton in `AppContainer`; gated methods; sync restore at creation |
| `Provider.autoDispose` projection | projection hook: `useStore(container.x, selector)` + `useShallow`, composing into `ScreenData`; dies with screen |
| `NotifierProvider.autoDispose` inputs | screen-local store: `useMemo(() => createStore(...), [])` — unmount = dispose |
| `.family` | hook arg + keyed map inside the store (search results, fetched bills), entries created on demand |
| freezed sealed union | TS discriminated union + `assertNever` |
| `AsyncValue<T>` | `Async<T>` union; projections exhaust loading/data/error |
| `.select()` isolation | one `useStore` selector per slice; `useShallow` for object slices |
| `uiEventProvider` | `UiEventQueue` vanilla store; root subscription shows toast + consumes once |
| GoRouter + redirect | React Navigation 7 Static API; auth-gated `if`-groups keyed on `useStore(auth, isAuthenticated)`; typed via `StaticParamList` + `declare global` |
| `StaleWhileRevalidate` mixin | `Freshness` composed into catalog/dueBills stores; `AppState` `active` → `refreshIfStale` |
| `clockProvider` etc. | `createAppContainer(overrides?)` composition root + React context; tests inject fakes |
| `ProviderContainer` tests | headless vanilla stores: `getState` / `subscribe`; jest fake timers for debounce/SWR |
| catalog SWR 30 min / dueBills SWR 5 min | `Freshness(clock, 30*60_000)` / `Freshness(clock, 5*60_000)` |
| search debounce 200 ms | `setTimeout` inside search store, epoch-checked; min-2 enforced in projection |

## License

[MIT](LICENSE) © ApnaMart

# Navigation Architecture — Design

Status: proposed. Companion research: [navigation-research.md](navigation-research.md). Extends [ARCHITECTURE.md](../ARCHITECTURE.md) routing section.

Router: go_router 17.x (official, maintenance mode — acceptable: deep linking is its strongest area, all limits known and worked around below).

## Goals

A navigation layer where every scenario below works by construction, not by patching:

1. Deep links / app links open any screen with a correct back stack
2. Guarded links — unauthenticated deep link → login → land on the originally intended screen
3. Back button + predictive back gesture always do the expected thing, never exit accidentally
4. Session restoration — cold start mid-session resumes where the user was
5. Tabs with independent stacks (architecture-ready; app adoption decided later)
6. Routable dialogs/sheets (pattern provided; app adoption decided later)
7. Master-detail and responsive chrome from the same URLs
8. Web: URL is shareable, reload-safe, browser back works

## Principles (the contract)

### P1 — URL is the only navigation truth
Every screen is reachable and fully restorable from its URL alone. `extra` is banned — it does not survive deep links, web reload, browser back, or process death. Complex payloads travel as path/query params or are re-derived from providers by ID.

Already true in this app: `/biller/x/review?account=..&amp;amount=..`.

### P2 — Route tree mirrors screen hierarchy
Nested `routes:` so the synthesized page stack equals the URL segments. Deep link to `/biller/x/review` builds `[Home, BillFetch, Review]`; back walks up, never exits. This is Flutter's equivalent of Android's `TaskStackBuilder` synthetic back stack.

Corollaries:
- `context.go()` everywhere; `push` only for explicit stack-on-top semantics (modals, transient flows). `push` never synthesizes parents and degrades web URLs.
- A screen's canonical parent is encoded by where its route nests, nowhere else.

### P3 — Tri-state auth gate
`Auth` gains an `unknown` initial state (today restore is sync, so `unknown` resolves immediately; the state exists so async token refresh later changes nothing structurally).

Top-level redirect:

```
unknown                          -> /splash            (hold; never /login — deep link survives)
unauthenticated, not on /login   -> /login?from=<matchedLocation>
authenticated, on /login|/splash -> from ?? /
else                             -> null
```

Rules:
- `from` is encoded manually into the login URL — go_router drops query params and `extra` across redirects (flutter#182469).
- A guard must return `null` when already at its own target — loop prevention; `redirectLimit` is a backstop, not a mechanism.
- Router is a plain keep-alive `Provider<GoRouter>`, never rebuilt; reactivity comes only from `refreshListenable` (existing `AuthListenable` pattern, kept).
- Non-http(s) URIs reaching redirect return `null` (custom-scheme double-redirect, flutter#169850).

### P4 — Pending-link stash and replay
A small `PendingLinkStore` in `core/router/`: when a deep link arrives while navigation cannot complete it (auth unknown, shell not mounted, app not initialized), the URI is stashed; the moment the blocker clears, it is replayed once and cleared.

Covers: cold-start deep link races, push-notification taps before init, deep-link-into-tab branch wipe (flutter#158987), login round-trips that need more than the `from` param.

### P5 — Typed route facade, no codegen
`Routes` — one Dart class with static functions returning URL strings: `Routes.biller(id)`, `Routes.review(billerId, {account, amount})`, `Routes.login({from})`. Single place that knows URL shapes; screens never concatenate strings. Matches the repo's no-codegen Riverpod stance; go_router_builder rejected (mixin syntax, single-file constraint, `$extra` trap).

### P6 — Back policy, predictive-back native
- `android:enableOnBackInvokedCallback="true"` in the manifest (not added by `flutter create`; opt-out from Android 16).
- `PopScope<T>` + `onPopInvokedWithResult` only; `WillPopScope` banned (disables predictive back).
- PopScope is a listener, never a veto: `canPop: false` → confirm dialog → manual `context.pop()` (which intentionally bypasses `canPop`). Async work only behind `canPop: false`.
- Interception is reserved for genuine unsaved-data loss (e.g. mid-payment form). No exit-confirm on home, no double-back-to-exit — anti-patterns under predictive back.
- Per route: PopScope XOR `GoRoute.onExit`, never both (they don't compose; see flutter#180002, #154608 before using onExit inside shells).
- Back never switches tabs (Material spec); within a branch back walks that branch's stack, at branch root back exits per platform default.

### P7 — Tabs: StatefulShellRoute.indexedStack (architecture-ready)
Decision on app adoption deferred. The architecture commits to the shape:

- One `StatefulShellRoute.indexedStack`, one `StatefulShellBranch` per tab, each with its own `navigatorKey`. Per-tab stacks and scroll positions preserved by construction.
- Tab switch: `navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex)` — re-tapping the active tab pops it to root.
- Fullscreen flows (e.g. an in-progress payment) declare `parentNavigatorKey: rootNavigatorKey` — rendered above the shell, back returns into it.
- Deep link into a non-initial tab goes through the PendingLinkStore replay (P4) — direct `go` from outside the shell wipes the branch stack (#142226, #158987).
- Recommended mapping for this app if adopted: Home and History as the two branches; everything else unchanged.

### P8 — Responsive chrome over a stable nav core
The shell widget owns zero navigation state. `LayoutBuilder` swaps chrome by width — `NavigationBar` (compact) ↔ `NavigationRail` (medium+) — around the same `navigationShell` body. Tab stacks survive the swap because state lives in branch navigators, not chrome. No package: flutter_adaptive_scaffold is discontinued; NavigationSuiteScaffold is Compose-only.

Master-detail: selection is a path param (`/category/:id/biller/:billerId`); wide layouts render list + detail panes from one URL, narrow layouts render the same URL as a pushed detail. Both layouts deep-link and restore identically because of P1.

### P9 — Routable modals (pattern-ready)
Decision on app adoption deferred. The architecture commits to the shape:

- `DialogPage<T>` and `SheetPage<T>` in `core/router/` — `Page` subclasses whose `createRoute` returns `DialogRoute` / `ModalBottomSheetRoute`. Registered via `pageBuilder`, so modals get URLs, deep links can open them, and system back / predictive gesture dismisses them (ModalBottomSheetRoute supports predictive back natively).
- Responsive: one route whose `pageBuilder` picks `SheetPage` (compact) or `DialogPage` (wide) from window size.
- `showDialog` / `showModalBottomSheet` remain allowed only for throwaway UI that must never be linkable or restorable.
- Recommended first use if adopted: payment confirmation before `pay()`.

## Deep link platform configuration (decided)

Custom scheme and HTTPS app links, both:

- Android: `billpay://` intent filter, plus `https://billpay.example.com` intent filter with `android:autoVerify="true"`; `assetlinks.json` documented with placeholder fingerprint (untestable without hosted domain — config-as-documentation).
- iOS: URL Types for `billpay://`, Associated Domains `applinks:billpay.example.com`, AASA file documented.
- Path whitelist at the native layer mirrors the route tree — unmatched URLs never open the app (validation layer 1); `onException` handles unmapped paths in-app (layer 2); screens verify the entity exists and show graceful not-found (layer 3).
- Incoming URIs normalized in one place (lowercasing per v15 case-sensitivity, custom-scheme authority/path fix-up) before matching.

## Web (recommendation, decision open)

Path URL strategy (`usePathUrlStrategy()`) recommended — clean URLs match the app-links posture; requires server rewrite of all paths to `index.html`, documented as a deploy constraint. Fallback: keep hash default, zero config. Page titles set via `Page.title` in pageBuilders.

## Known upstream bugs accepted and mitigated

| Bug | Mitigation |
|---|---|
| iOS cold start flashes `/`, redirect runs twice (#142988) | Splash gate (P3) absorbs the flash; redirect is idempotent |
| Android warm-resume restarts UI (#176080, 3.35.4+ regression) | PendingLinkStore replay restores location; track upstream |
| Params dropped across redirect (#182469) | Manual `from` encoding |
| Deep link into branch wipes stack (#158987) | Stash-and-replay (P4) |
| Restoration restores location only, broken in shells (#174935) | P1 means location is sufficient; widget state re-derives from providers |
| Predictive peek broken through nested navigators (#152323) | Accept: peek falls back to fade inside shells |

## Module layout

```
lib/core/router/
  app_router.dart          router provider, route table, redirect
  routes.dart              typed URL facade (P5)
  auth_gate.dart           tri-state redirect logic, pure function — unit-testable
  pending_link.dart        PendingLinkStore (P4)
  link_normalizer.dart     scheme/case/authority normalization, pure — unit-testable
  modal_pages.dart         DialogPage / SheetPage (P9)
  shell.dart               responsive scaffold + navigationShell (P7/P8, when adopted)
```

Redirect logic and link normalization are pure functions taking `(authState, Uri)` → decision, fully unit-tested without widgets — same testing stance as ARCHITECTURE.md (no mocks, ProviderContainer + overrides).

## Test matrix (acceptance)

Every guarantee gets a test:

1. Deep link cold start, logged in → target screen, back walks to home, never exits
2. Deep link cold start, logged out → login → success → original target, back stack correct
3. Deep link while auth unknown → splash → resolve → target (no `/login` flash, no `/` flash leak)
4. Redirect idempotence: every redirect output re-fed produces `null` (loop-freedom property test)
5. `from` round-trip survives login including query params
6. Back at home root → app exits (no veto); back mid-flow → parent screen
7. Unsaved-payment-form back → confirm dialog → stay/leave both correct
8. Tab deep link (when adopted): branch stack intact after replay; re-tap active tab pops to root; back never switches tabs
9. Modal route (when adopted): URL opens modal directly; back/gesture dismisses to parent route
10. Master-detail: same URL renders two-pane wide / pushed narrow; resize preserves selection
11. Web: reload on any route restores it; browser back mirrors in-app back
12. Link normalization: case variants, `app://host/path` forms, unknown paths → not-found

## Decision log

| Decision | Status |
|---|---|
| Stay on go_router 17.x, harden | Decided |
| URL-only state, no `extra` | Decided |
| Tri-state auth + `from` + splash gate | Decided |
| Custom scheme + HTTPS app links config | Decided |
| Typed facade, no codegen | Decided |
| Predictive-back-native policy | Decided |
| Tabs in this app (Home/History branches) | Open — architecture ready |
| Routable modals in this app (payment confirm) | Open — pattern ready |
| Web path vs hash strategy | Open — path recommended |

## Rollout phases

1. Core hardening: tri-state auth, `from` round-trip, splash gate, typed facade, link normalizer, manifest flag — no visual change
2. Deep link platform config + PendingLinkStore + cold/warm start tests
3. Back policy: PopScope on payment form, exit-behavior tests
4. Deferred decisions: tabs, modals, master-detail, web strategy — each lands as its own phase when approved

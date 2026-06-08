# Navigation Research — go_router 17.x (June 2026)

Source research for the navigation architecture. Facts verified against pub.dev, docs.flutter.dev, flutter/flutter issues.

## Package status

- go_router 17.3.0 — official, maintenance mode ("feature-complete", bug fixes only). Still recommended for ~90% of apps. Structural limits will not be redesigned.
- go_router_builder 4.3.0 — typed codegen; `$`-mixin syntax, single-file constraint, `$extra` defeats deep links/web.
- auto_route 11.1.0 — active, codegen-required, single-maintainer risk, weaker deep-link story.
- beamer stalled (~20 months), routemaster compat-only, flutter_adaptive_scaffold DISCONTINUED (fork: canonical_adaptive_scaffold).
- Custom Navigator 2.0 — verbosity criticized officially (flutter#69315); last resort.

## Deep links / app links

- Mechanism: nested `routes:` tree + `go` semantics. Back stack == URL segments — Flutter's equivalent of Android `TaskStackBuilder` synthetic stack.
- `push` never synthesizes parents; deep links always use `go` semantics. Rule: `go` everywhere.
- `extra` NEVER survives deep link / web reload / browser back. All nav state must live in path/query params.
- URLs case-sensitive since v15 (`caseSensitive` default true).
- Custom scheme `app://details/123` parses `details` as authority not path — use `app:///details/123` or normalize in redirect; return `null` in redirect for non-http(s) schemes (flutter#169850).
- Open bugs: iOS cold start flashes `/` then deep link, redirect runs twice (flutter#142988, P2). Android warm-resume restarts UI, nav state lost — regression 3.35.4+ (flutter#176080, P2).
- Validation layers: (1) native whitelist (AndroidManifest intent filters / AASA), (2) `errorBuilder`/`onException` for unmapped paths, (3) content-exists check with graceful not-found.
- iOS universal links require valid apple-app-site-association; Android app links require assetlinks.json + `autoVerify`.

## Auth guards + session restore

- Canonical: top-level `redirect` + `/login?from=${state.matchedLocation}`; after login return `state.uri.queryParameters['from'] ?? '/'`.
- Query params + `extra` dropped ACROSS redirects (flutter#182469) — encode `from` manually.
- Redirect loop = guard returning non-null for its own target; `redirectLimit` (5) is backstop only.
- Tri-state auth: `unknown → authenticated | unauthenticated`. While `unknown` → `/splash`, never `/login` (deep link lost otherwise). `refreshListenable` re-runs guard on resolve.
- Riverpod wiring: router = plain `Provider` (never autoDispose, never rebuilt); `refreshListenable` via `Notifier implements Listenable`; `ref.read` in redirect closure, never `ref.watch` in provider body.
- Repo today: binary redirect, no `from` round-trip, sync restore (no `unknown` state). Correct wiring otherwise (app_router.dart).

## Back stack / Android back / predictive back

- Framework predictive back stable Flutter 3.16; predictive page transitions DEFAULT since 3.38 (`PredictiveBackPageTransitionsBuilder`, 450ms). Stale docs page claims otherwise — trust breaking-changes pages.
- Manifest: `android:enableOnBackInvokedCallback="true"` (not added by `flutter create`). Android 16 / API 36+: opt-out instead of opt-in; `onBackPressed`/`KEYCODE_BACK` no longer delivered.
- `WillPopScope` deprecated AND disables predictive back. `PopScope<T>` + `onPopInvokedWithResult` (since 3.22). `canPop` is ahead-of-time toggle, not veto.
- `context.pop()` bypasses `canPop` — intended escape hatch for confirm-then-pop: `canPop: false` → dialog → manual pop.
- `GoRoute.onExit` = async veto. PopScope vs onExit don't compose — one mechanism per route. Bugs: #180002 (async onEnter+redirect+onExit → "Future already completed"), #154608 (onExit skipped popping last ShellRoute child).
- NavigatorPopHandler (`onPopWithResult`) for nested navigators; predictive peek broken through nested navigators (#152323); AppBar back button not synced (#170220).
- FlutterFragmentActivity predictive-back gap FIXED Feb 2026 (PR #181124). FlutterActivity fine either way; #153672 (FragmentActivity back exits app) historical.
- Exit-confirm / double-back-to-exit on home = anti-pattern under predictive back. Reserve interception for unsaved changes only.
- IME consumes first back; second back pops route/sheet.
- Handling deep link inside `redirect` collapses multi-page stack (#163635).

## Tabs

- `StatefulShellRoute.indexedStack`: per-branch parallel Navigators, lazy-built, all alive once visited (memory cost), `preload:` opt-in (since 14.4.0).
- Double-tap-to-root: `navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex)`.
- Back NEVER switches tabs — Material/Android spec (developer.android.com/guide/navigation/principles). iOS: no system back across tabs either.
- Known holes: deep link into tab wipes branch stack (#158987 open); `go` to branch from outside shell resets its stack (#142226); no clean branch-reset API (#132906); fullscreen-over-tabs = `parentNavigatorKey: rootNavigatorKey`.
- Stash-and-replay pattern for deep-link-into-tab: store URI during splash/auth, `push` after shell mounts.
- PopScope on branch roots fixed in 14.6.1/15.2.2; iOS back gesture popping whole shell fixed 16.2.3.

## Responsive / master-detail

- flutter_adaptive_scaffold discontinued; NavigationSuiteScaffold is Compose-only, no Flutter equivalent. Roll own: LayoutBuilder + NavigationBar ↔ NavigationRail.
- Chrome swap is state-safe: nav state lives in branch navigators (`navigationShell`), not the scaffold chrome. Same `navigationShell` body under both chromes.
- Master-detail: selected item = path param (`/items/:id`), ShellRoute keeps list pane persistent, LayoutBuilder branches 1-pane vs 2-pane, `go` on list taps. Same URL both layouts. (flutter#106288 canonical thread.)

## Routable dialogs / sheets

- Root problem: showDialog/showModalBottomSheet push Routes, not Pages — invisible to go_router (#1 community complaint; #146578 race, #100933, #119619).
- Solution: custom `Page<T>` subclass, `createRoute` returns `DialogRoute` / `ModalBottomSheetRoute`, registered via `pageBuilder` → URL-addressable modals (croxx5f pattern).
- `ModalBottomSheetRoute` supports predictive back natively.
- wolt_modal_sheet 0.11.0 (1.47k likes): responsive sheet↔dialog↔side-sheet via `modalTypeBuilder`; no go_router wiring built in.
- Replacing one sheet with another silently fails (#146517).

## Web

- Default hash URL strategy; `usePathUrlStrategy()` needs server rewrite to index.html else 404 on refresh (#107996).
- Browser back/forward work with go_router stack; `await context.push()` result pattern OK but imperative Navigator breaks URL fidelity.
- Page titles: no `GoRoute.title` — set via `Page.title` in pageBuilder.
- State restoration: `restorationScopeId` on MaterialApp.router + GoRouter + shell branches; restores location only, NOT widget state; broken inside ShellRoute (#174935, #117683).
- Deep link ignored when killed activity restored from background (#96820).

## Push notifications / cold start

- Cold-start race: navigation fires before init → gate behind splash, stash URI, replay after init+auth. Prefer FCM data-only messages for nav control.

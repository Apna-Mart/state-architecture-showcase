# State Architecture Showcase

One product. One set of architecture rules. Multiple frameworks.

This repository implements the same bill-payments app — phone-OTP auth, localized biller catalog (en/hi/ar with RTL), bill fetch and review, payments with history and receipts, saved billers with due-bill reminders, persisted theme and language — once per framework, each on its own orphan branch with independent history.

## Branches

| Branch | Framework | Stack |
|---|---|---|
| [`flutter-riverpod`](../../tree/flutter-riverpod) | Flutter | Riverpod 3 (manual providers), freezed sealed unions, GoRouter, intl |
| [`android-compose`](../../tree/android-compose) | Jetpack Compose | Hilt, StateFlow stores + ViewModel projections, Navigation 3, kotlinx-serialization |

Each branch's `README.md` carries the full architecture rulebook and, where ported, the mapping table from the original.

## The Rules (shared across every implementation)

- Two layers: long-lived stores hold facts; screen-scoped projections derive sealed `ScreenData` unions. UI is dumb — data in, callbacks out.
- Every multi-phase state is a sealed union. No `isLoading`/`isError` boolean soups. Validation is derived, never stored.
- Persistence by intent: money records are write-through and never rolled back; preferences are optimistic with rollback. Per-user key scoping, epoch counters discard stale work on user switch.
- Every caught failure emits a one-shot UI event — no silent catches.
- Stale-while-revalidate caching with an injectable clock.
- Router is owned state with an auth gate; all navigation state lives in typed route keys.
- Tests use fakes, never mocks: in-memory storage, seeded fake network, fixed clocks, rebuild/emission isolation checks.

## Explore

```bash
git clone <repo-url>
cd state-architecture-showcase
git switch flutter-riverpod   # or android-compose
```

Build and run instructions live in each branch's `README.md`.

## License

[MIT](LICENSE)

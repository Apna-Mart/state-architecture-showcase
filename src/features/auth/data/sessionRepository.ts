import type { KeyValueStore } from '@/core/storage/keyValueStore';

export type StoredSession = { userId: string; phone: string };

export interface SessionRepository {
  restore(): StoredSession | null;
  save(userId: string, phone: string): void;
  clear(): void;
}

export class StoredSessionRepository implements SessionRepository {
  private static readonly userIdKey = 'session.userId';
  private static readonly phoneKey = 'session.phone';

  constructor(private readonly store: KeyValueStore) {}

  restore(): StoredSession | null {
    const userId = this.store.read(StoredSessionRepository.userIdKey);
    const phone = this.store.read(StoredSessionRepository.phoneKey);
    if (userId === null || phone === null) return null;
    return { userId, phone };
  }

  save(userId: string, phone: string): void {
    this.store.write(StoredSessionRepository.userIdKey, userId);
    this.store.write(StoredSessionRepository.phoneKey, phone);
  }

  clear(): void {
    this.store.remove(StoredSessionRepository.userIdKey);
    this.store.remove(StoredSessionRepository.phoneKey);
  }
}

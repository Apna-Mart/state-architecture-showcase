import type { KeyValueStore } from '../../../core/storage/keyValueStore';

export interface Session { readonly userId: string; readonly phone: string }

export interface SessionRepository {
  restore(): Session | null;
  save(userId: string, phone: string): Promise<void>;
  clear(): Promise<void>;
}

const USER_ID_KEY = 'session.userId';
const PHONE_KEY = 'session.phone';

export class StoredSessionRepository implements SessionRepository {
  constructor(private readonly store: KeyValueStore) {}

  restore(): Session | null {
    const userId = this.store.read(USER_ID_KEY);
    const phone = this.store.read(PHONE_KEY);
    if (userId === null || phone === null) return null;
    return { userId, phone };
  }

  async save(userId: string, phone: string): Promise<void> {
    await this.store.write(USER_ID_KEY, userId);
    await this.store.write(PHONE_KEY, phone);
  }

  async clear(): Promise<void> {
    await this.store.remove(USER_ID_KEY);
    await this.store.remove(PHONE_KEY);
  }
}

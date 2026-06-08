import { StoredSessionRepository } from '@/features/auth/data/sessionRepository';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';

describe('StoredSessionRepository', () => {
  it('restore returns null when no session, then round-trips save/clear', async () => {
    const store = new InMemoryKeyValueStore();
    const repo = new StoredSessionRepository(store);
    expect(repo.restore()).toBeNull();
    await repo.save('user-9', '9');
    expect(repo.restore()).toEqual({ userId: 'user-9', phone: '9' });
    expect(store.read('session.userId')).toBe('user-9');
    expect(store.read('session.phone')).toBe('9');
    await repo.clear();
    expect(repo.restore()).toBeNull();
  });
});

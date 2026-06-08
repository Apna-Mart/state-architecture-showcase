import { StoredSavedBillersRepository } from '@/features/saved_billers/data/savedBillersRepository';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';
import { emptySavedBillers, addingSaved } from '@/features/saved_billers/data/savedBiller';

describe('StoredSavedBillersRepository', () => {
  it('restore is empty for unknown user and round-trips persisted items', async () => {
    const store = new InMemoryKeyValueStore();
    const repo = new StoredSavedBillersRepository(store);
    expect(repo.restore('user-x')).toEqual(emptySavedBillers());
    await repo.persist('user-9', addingSaved(emptySavedBillers(), { billerId: 'b', account: 'a', nickname: 'Home' }));
    expect(repo.restore('user-9').items[0]!.nickname).toBe('Home');
  });
});

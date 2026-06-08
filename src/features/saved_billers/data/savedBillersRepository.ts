import type { KeyValueStore } from '../../../core/storage/keyValueStore';
import { emptySavedBillers, type SavedBiller, type SavedBillers } from './savedBiller';

export interface SavedBillersRepository {
  restore(userId: string): SavedBillers;
  persist(userId: string, value: SavedBillers): Promise<void>;
}

const keyFor = (userId: string): string => `savedBillers.${userId}`;

export class StoredSavedBillersRepository implements SavedBillersRepository {
  constructor(private readonly store: KeyValueStore) {}

  restore(userId: string): SavedBillers {
    const raw = this.store.read(keyFor(userId));
    if (raw === null) return emptySavedBillers();
    const decoded = JSON.parse(raw) as SavedBiller[];
    return { items: decoded.map((e) => ({ billerId: e.billerId, account: e.account, nickname: e.nickname })) };
  }

  persist(userId: string, value: SavedBillers): Promise<void> {
    return this.store.write(keyFor(userId), JSON.stringify(value.items));
  }
}

import { InMemoryKeyValueStore, MmkvKeyValueStore } from '@/core/storage/keyValueStore';
import { createMMKV } from 'react-native-mmkv';

describe('InMemoryKeyValueStore', () => {
  it('reads back what it writes and removes', async () => {
    const store = new InMemoryKeyValueStore();
    expect(store.read('k')).toBeNull();
    await store.write('k', 'v');
    expect(store.read('k')).toBe('v');
    await store.remove('k');
    expect(store.read('k')).toBeNull();
  });
});

describe('MmkvKeyValueStore', () => {
  it('persists via the MMKV instance', async () => {
    const store = new MmkvKeyValueStore(createMMKV());
    await store.write('a', '1');
    expect(store.read('a')).toBe('1');
    await store.remove('a');
    expect(store.read('a')).toBeNull();
  });
});

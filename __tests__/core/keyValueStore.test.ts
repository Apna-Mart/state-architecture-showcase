import { InMemoryKeyValueStore, ThrowingWriteStore } from '@/core/storage/keyValueStore';

describe('InMemoryKeyValueStore', () => {
  test('write then read returns the value; remove clears it', () => {
    const store = new InMemoryKeyValueStore();
    store.write('k', 'v');
    expect(store.read('k')).toBe('v');
    store.remove('k');
    expect(store.read('k')).toBeNull();
  });

  test('read of unknown key returns null', () => {
    expect(new InMemoryKeyValueStore().read('missing')).toBeNull();
  });

  test('ThrowingWriteStore throws only for the configured prefix', () => {
    const store = new ThrowingWriteStore('payments.');
    expect(() => store.write('payments.user-1', 'x')).toThrow();
    store.write('session.userId', 'u');
    expect(store.read('session.userId')).toBe('u');
  });
});

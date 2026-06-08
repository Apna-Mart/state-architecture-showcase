import { createMMKV, type MMKV } from 'react-native-mmkv';

export interface KeyValueStore {
  read(key: string): string | null;
  write(key: string, value: string): void;
  remove(key: string): void;
}

export class InMemoryKeyValueStore implements KeyValueStore {
  protected readonly values = new Map<string, string>();

  read(key: string): string | null {
    return this.values.get(key) ?? null;
  }

  write(key: string, value: string): void {
    this.values.set(key, value);
  }

  remove(key: string): void {
    this.values.delete(key);
  }
}

export class ThrowingWriteStore extends InMemoryKeyValueStore {
  constructor(private readonly failingPrefix: string) {
    super();
  }

  write(key: string, value: string): void {
    if (key.startsWith(this.failingPrefix)) throw new Error('disk full');
    super.write(key, value);
  }
}

export class MmkvKeyValueStore implements KeyValueStore {
  private readonly mmkv: MMKV = createMMKV();

  read(key: string): string | null {
    return this.mmkv.getString(key) ?? null;
  }

  write(key: string, value: string): void {
    this.mmkv.set(key, value);
  }

  remove(key: string): void {
    this.mmkv.remove(key);
  }
}

import type { MMKV } from 'react-native-mmkv';

export interface KeyValueStore {
  read(key: string): string | null;
  write(key: string, value: string): Promise<void>;
  remove(key: string): Promise<void>;
}

export class InMemoryKeyValueStore implements KeyValueStore {
  private readonly values = new Map<string, string>();

  read(key: string): string | null {
    return this.values.get(key) ?? null;
  }

  async write(key: string, value: string): Promise<void> {
    this.values.set(key, value);
  }

  async remove(key: string): Promise<void> {
    this.values.delete(key);
  }
}

export class MmkvKeyValueStore implements KeyValueStore {
  constructor(private readonly mmkv: MMKV) {}

  read(key: string): string | null {
    return this.mmkv.getString(key) ?? null;
  }

  async write(key: string, value: string): Promise<void> {
    this.mmkv.set(key, value);
  }

  async remove(key: string): Promise<void> {
    this.mmkv.remove(key);
  }
}

export class ThrowingWritesKeyValueStore extends InMemoryKeyValueStore {
  constructor(private readonly failingPrefix: string) {
    super();
  }

  override async write(key: string, value: string): Promise<void> {
    if (key.startsWith(this.failingPrefix)) throw new Error('disk full');
    return super.write(key, value);
  }
}

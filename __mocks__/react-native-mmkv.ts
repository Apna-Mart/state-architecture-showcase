export class MMKV {
  private store = new Map<string, string>();
  getString(key: string): string | undefined {
    return this.store.get(key);
  }
  set(key: string, value: string): void {
    this.store.set(key, value);
  }
  remove(key: string): boolean {
    return this.store.delete(key);
  }
}
export const createMMKV = (): MMKV => new MMKV();

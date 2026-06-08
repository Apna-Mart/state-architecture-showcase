export type Async<T> =
  | { readonly status: 'loading' }
  | { readonly status: 'data'; readonly value: T }
  | { readonly status: 'error'; readonly error: unknown };

export const asyncLoading = <T>(): Async<T> => ({ status: 'loading' });
export const asyncData = <T>(value: T): Async<T> => ({ status: 'data', value });
export const asyncError = <T>(error: unknown): Async<T> => ({ status: 'error', error });

export const asyncValueOrNull = <T>(a: Async<T>): T | null =>
  a.status === 'data' ? a.value : null;

export const isLoading = <T>(a: Async<T>): boolean => a.status === 'loading';

export const assertNever = (x: never): never => {
  throw new Error(`Unhandled union member: ${JSON.stringify(x)}`);
};

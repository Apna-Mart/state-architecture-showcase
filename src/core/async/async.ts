export type Async<T> =
  | { status: 'loading' }
  | { status: 'data'; value: T }
  | { status: 'error'; error: unknown };

export function assertNever(value: never): never {
  throw new Error(`Unhandled case: ${JSON.stringify(value)}`);
}

type QueryLike<T> = {
  isPending: boolean;
  isError: boolean;
  data: T | undefined;
  error: unknown;
};

export function fromQuery<T>(query: QueryLike<T>): Async<T> {
  if (query.isError) return { status: 'error', error: query.error };
  if (query.data !== undefined) return { status: 'data', value: query.data };
  return { status: 'loading' };
}

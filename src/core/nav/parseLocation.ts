import type { RootParamList } from './navigation';

export type NavTarget = { readonly [K in keyof RootParamList]: { name: K; params: RootParamList[K] } }[keyof RootParamList];

export const parseLocation = (location: string): NavTarget => {
  const [path, query = ''] = location.split('?');
  const params = new URLSearchParams(query);
  const segments = (path ?? '').split('/').filter(Boolean);
  if (segments[0] === 'category') return { name: 'Category', params: { categoryId: segments[1] } } as NavTarget;
  if (segments[0] === 'biller' && segments[2] === 'review') {
    const amount = params.get('amount');
    return {
      name: 'BillReview',
      params: { billerId: segments[1], account: params.get('account') ?? '', amountPaise: amount === null ? undefined : Number(amount) },
    } as NavTarget;
  }
  if (segments[0] === 'biller') return { name: 'BillFetch', params: { billerId: segments[1] } } as NavTarget;
  if (segments[0] === 'payment') return { name: 'Receipt', params: { paymentId: segments[1] } } as NavTarget;
  return { name: 'Home', params: undefined } as NavTarget;
};

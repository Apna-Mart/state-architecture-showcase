import { useQuery } from '@tanstack/react-query';
import { useContainer } from '@/core/containerContext';
import type { FetchedBill } from './fetchedBill';

export const billKey = (billerId: string, account: string) => ['bill', billerId, account] as const;

export function useBillQuery(billerId: string, account: string, enabled = true) {
  const { billRepository } = useContainer();
  return useQuery<FetchedBill>({
    queryKey: billKey(billerId, account),
    queryFn: () => billRepository.fetchBill(billerId, account),
    enabled,
  });
}

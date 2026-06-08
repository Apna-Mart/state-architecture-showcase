import { useQuery } from '@tanstack/react-query';
import { useStore } from 'zustand';
import { useShallow } from 'zustand/react/shallow';
import { useContainer } from '@/core/containerContext';
import { userIdOrNull } from '@/features/auth/data/auth';
import type { SavedBiller } from '@/features/saved_billers/data/savedBiller';
import type { FetchedBill } from './fetchedBill';

const savedHash = (items: SavedBiller[]): string => items.map((s) => `${s.billerId}|${s.account}`).join(',');

export function useDueBillsQuery() {
  const container = useContainer();
  const userId = useStore(container.auth, (s) => userIdOrNull(s.auth));
  const saved = useStore(container.savedBillers, useShallow((s) => s.savedBillers.items));
  return useQuery<FetchedBill[]>({
    queryKey: ['dueBills', userId, savedHash(saved)],
    queryFn: () => (saved.length === 0 ? Promise.resolve([]) : container.billRepository.fetchDueBills(saved)),
    enabled: userId !== null,
    staleTime: 5 * 60_000,
  });
}

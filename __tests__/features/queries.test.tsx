import { renderHook, waitFor } from '@testing-library/react-native';
import type { ReactNode } from 'react';
import { createAppContainer } from '@/core/container';
import { ContainerProvider } from '@/core/containerContext';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { useCatalogQuery } from '@/features/billers/data/catalogQueries';
import { useDueBillsQuery } from '@/features/bills/data/dueBillsQueries';
import { useBillQuery } from '@/features/bills/data/billQueries';

const makeWrapper = () => {
  const container = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
  const wrapper = ({ children }: { children: ReactNode }) => (
    <ContainerProvider container={container}>{children}</ContainerProvider>
  );
  return { container, wrapper };
};

test('catalog query resolves 15 categories', async () => {
  const { wrapper } = makeWrapper();
  const { result } = await renderHook(() => useCatalogQuery('en'), { wrapper });
  await waitFor(() => expect(result.current.data?.categories).toHaveLength(15));
});

test('dueBills query is empty for a user with no saved billers', async () => {
  const { container, wrapper } = makeWrapper();
  await container.auth.getState().sendOtp('9876543210');
  await container.auth.getState().verifyOtp('123456');
  const { result } = await renderHook(() => useDueBillsQuery(), { wrapper });
  await waitFor(() => expect(result.current.isPending).toBe(false));
  expect(result.current.data).toEqual([]);
});

test('bill query resolves a deterministic bill', async () => {
  const { wrapper } = makeWrapper();
  const { result } = await renderHook(() => useBillQuery('electricity-metro', 'K123'), { wrapper });
  await waitFor(() => expect(result.current.data?.amountPaise).toBeGreaterThanOrEqual(20000));
});

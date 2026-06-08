import { renderHook, act, waitFor } from '@testing-library/react-native';
import type { ReactNode } from 'react';
import { createAppContainer } from '@/core/container';
import { ContainerProvider } from '@/core/containerContext';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { useDueBillsQuery } from '@/features/bills/data/dueBillsQueries';

test('successful pay invalidates dueBills so it refetches', async () => {
  const container = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1, failEvery: 100 }) });
  const wrapper = ({ children }: { children: ReactNode }) => (
    <ContainerProvider container={container}>{children}</ContainerProvider>
  );
  await container.auth.getState().sendOtp('9876543210');
  await container.auth.getState().verifyOtp('123456');
  await container.savedBillers.getState().save({ billerId: 'water-city', account: 'W9', nickname: 'Home' });
  const { result } = await renderHook(() => useDueBillsQuery(), { wrapper });
  await waitFor(() => expect(result.current.isPending).toBe(false));
  const before = result.current.dataUpdatedAt;
  await act(async () => {
    await container.payments.getState().pay({
      billerId: 'water-city', billerName: 'City Water', categoryId: 'water', account: 'W9', amountPaise: 30000,
    });
  });
  await waitFor(() => expect(result.current.dataUpdatedAt).toBeGreaterThan(before));
});

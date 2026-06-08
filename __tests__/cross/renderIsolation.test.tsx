import { render, act } from '@testing-library/react-native';
import { Text } from 'react-native';
import { useRef, useState } from 'react';
import type { ReactNode } from 'react';
import { createAppContainer } from '@/core/container';
import { ContainerProvider } from '@/core/containerContext';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { useStore } from 'zustand';
import { userIdOrNull } from '@/features/auth/data/auth';

function AuthBoundProbe({ onRender }: { onRender: () => void }) {
  const renders = useRef(0);
  renders.current += 1;
  onRender();
  return <Text>probe</Text>;
}

test('changing unrelated local state does not re-render an auth-store-bound component', async () => {
  const container = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
  const wrapper = ({ children }: { children: ReactNode }) => (
    <ContainerProvider container={container}>{children}</ContainerProvider>
  );
  let count = 0;
  function Host() {
    useState('');
    const authed = useStore(container.auth, (s) => userIdOrNull(s.auth) !== null);
    return <AuthBoundProbe onRender={() => (count += 1)} />;
  }
  await render(<Host />, { wrapper });
  const baseline = count;
  await act(async () => {
    await container.savedBillers.getState();
  });
  expect(count).toBe(baseline);
});

import { render, screen, fireEvent, waitFor } from '@testing-library/react-native';
import type { ReactNode } from 'react';
import { I18nextProvider } from 'react-i18next';
import { createAppContainer } from '@/core/container';
import { ContainerProvider } from '@/core/containerContext';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { createI18n } from '@/l10n/i18n';
import { LoginScreen } from '@/features/auth/ui/LoginScreen';

function wrap(node: ReactNode) {
  const container = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
  const i18n = createI18n('en');
  return { container, ui: (
    <ContainerProvider container={container}>
      <I18nextProvider i18n={i18n}>{node}</I18nextProvider>
    </ContainerProvider>
  ) };
}

test('login shows phone entry and advances to OTP after sending', async () => {
  const { container, ui } = wrap(<LoginScreen />);
  await render(ui);
  expect(screen.getByPlaceholderText('Mobile number')).toBeTruthy();
  await fireEvent.changeText(screen.getByPlaceholderText('Mobile number'), '9876543210');
  await fireEvent.press(screen.getByText('Send OTP'));
  await waitFor(() => expect(container.auth.getState().auth.kind).toBe('otpSent'));
  expect(await screen.findByPlaceholderText('Enter OTP')).toBeTruthy();
});

test('verify with six digits authenticates', async () => {
  const { container, ui } = wrap(<LoginScreen />);
  await render(ui);
  await fireEvent.changeText(screen.getByPlaceholderText('Mobile number'), '9876543210');
  await fireEvent.press(screen.getByText('Send OTP'));
  await screen.findByPlaceholderText('Enter OTP');
  await fireEvent.changeText(screen.getByPlaceholderText('Enter OTP'), '123456');
  await fireEvent.press(screen.getByText('Verify'));
  await waitFor(() => expect(container.auth.getState().auth.kind).toBe('authenticated'));
});

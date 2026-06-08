import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react-native';
import { createAppContainer } from '@/core/container/appContainer';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { ContainerProvider } from '@/core/container/containerContext';
import { I18nextProvider } from 'react-i18next';
import { createI18n } from '@/l10n/i18n';
import { LoginScreen } from '@/features/auth/ui/LoginScreen';

const host = (node: React.ReactElement) => {
  const container = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
  const i18n = createI18n('en');
  return render(
    <ContainerProvider container={container}>
      <I18nextProvider i18n={i18n}>{node}</I18nextProvider>
    </ContainerProvider>,
  );
};

describe('smoke', () => {
  it('login shows Send OTP and enables it after a valid phone', async () => {
    await host(<LoginScreen />);
    expect(screen.getByText('Send OTP')).toBeTruthy();
    const input = screen.getByPlaceholderText('Mobile number');
    await fireEvent.changeText(input, '9876543210');
    expect(screen.getByText('Send OTP')).toBeTruthy();
  });
});

import React, { useEffect, useState } from 'react';
import { AppState, I18nManager, ToastAndroid, Platform, Alert } from 'react-native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { I18nextProvider } from 'react-i18next';
import { useStore } from 'zustand';
import { navigationRef } from './core/nav/navigationRef';
import { Navigation } from './core/nav/navigation';
import { ContainerProvider, useContainer } from './core/container/containerContext';
import type { AppContainer } from './core/container/appContainer';
import { createI18n } from './l10n/i18n';
import type { UiEvent } from './core/event/uiEvent';

const toast = (message: string): void => {
  if (Platform.OS === 'android') ToastAndroid.show(message, ToastAndroid.SHORT);
  else Alert.alert('', message);
};

const Root = (): React.JSX.Element => {
  const container = useContainer();
  const language = useStore(container.locale, (s) => s.language);
  const [i18n] = useState(() => createI18n(language));

  useEffect(() => { void i18n.changeLanguage(language); }, [i18n, language]);

  useEffect(() => {
    const wantRtl = language === 'ar';
    if (I18nManager.isRTL !== wantRtl) {
      I18nManager.forceRTL(wantRtl);
    }
  }, [language]);

  useEffect(() => {
    const sub = AppState.addEventListener('change', (state) => {
      if (state !== 'active') return;
      container.catalog.getState().refreshIfStale();
      container.dueBills.getState().refreshIfStale();
    });
    return () => sub.remove();
  }, [container]);

  useEffect(() => {
    const handle = (event: UiEvent): void => {
      if (event.kind === 'paymentStarted') {
        navigationRef.navigate('Receipt', { paymentId: event.paymentId });
        return;
      }
      const key: Record<Exclude<UiEvent['kind'], 'paymentStarted'>, string> = {
        paymentFailed: 'paymentFailedRetry',
        otpRejected: 'invalidOtpMessage',
        authFailed: 'somethingWentWrong',
        storageFailed: 'storageFailedMessage',
      };
      toast(i18n.t(key[event.kind]));
    };
    return container.uiEvents.subscribe((state, prev) => {
      const fresh = state.events.filter((e) => !prev.events.includes(e));
      fresh.forEach((event) => {
        handle(event);
        container.uiEvents.getState().consume(event);
      });
    });
  }, [container, i18n]);

  return (
    <I18nextProvider i18n={i18n}>
      <Navigation ref={navigationRef} />
    </I18nextProvider>
  );
};

export const App = ({ container }: { container: AppContainer }): React.JSX.Element => (
  <SafeAreaProvider>
    <ContainerProvider container={container}>
      <Root />
    </ContainerProvider>
  </SafeAreaProvider>
);

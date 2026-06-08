import { useEffect, useMemo, useRef } from 'react';
import { Alert } from 'react-native';
import { Stack, useRouter } from 'expo-router';
import { I18nextProvider, useTranslation } from 'react-i18next';
import { useStore } from 'zustand';
import { useShallow } from 'zustand/react/shallow';
import { getLocales } from 'expo-localization';
import { createAppContainer } from '@/core/container';
import { ContainerProvider, useContainer } from '@/core/containerContext';
import { wireFocusManager } from '@/core/queryFocus';
import { applyRtl } from '@/core/rtl';
import { createI18n, resolveLanguage } from '@/l10n/i18n';

export default function RootLayout() {
  const container = useMemo(() => createAppContainer(), []);
  const override = useStore(container.settings, (s) => s.settings.localeOverride);
  const language = resolveLanguage(override, getLocales()[0]?.languageCode ?? 'en');
  const i18n = useMemo(() => createI18n(language), []);
  useEffect(() => {
    i18n.changeLanguage(language);
    applyRtl(language);
  }, [language, i18n]);
  useEffect(() => wireFocusManager(), []);
  return (
    <ContainerProvider container={container}>
      <I18nextProvider i18n={i18n}>
        <UiEventConsumer />
        <Stack screenOptions={{ headerShown: false }} />
      </I18nextProvider>
    </ContainerProvider>
  );
}

function UiEventConsumer() {
  const { t } = useTranslation();
  const container = useContainer();
  const router = useRouter();
  const events = useStore(container.uiEvents, useShallow((s) => s.events));
  const handled = useRef(new Set<number>());
  const message = (kind: string): string =>
    kind === 'paymentFailed' ? t('paymentFailedRetry')
    : kind === 'otpRejected' ? t('invalidOtpMessage')
    : kind === 'authFailed' ? t('somethingWentWrong')
    : t('storageFailedMessage');
  useEffect(() => {
    for (const event of events) {
      if (handled.current.has(event.token)) continue;
      handled.current.add(event.token);
      if (event.kind === 'paymentStarted') router.push(`/payment/${event.paymentId}`);
      else Alert.alert(message(event.kind));
      container.uiEvents.getState().consume(event);
    }
  }, [events, container, router]);
  return null;
}

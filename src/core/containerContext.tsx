import { createContext, useContext, type ReactNode } from 'react';
import { QueryClientProvider } from '@tanstack/react-query';
import { useStore } from 'zustand';
import { type AppContainer } from './container';
import { isSupportedLanguage, type SupportedLanguage } from '@/core/format/localeConfigs';
import { getLocales } from 'expo-localization';

const ContainerContext = createContext<AppContainer | null>(null);

export function ContainerProvider({ container, children }: { container: AppContainer; children: ReactNode }) {
  return (
    <ContainerContext.Provider value={container}>
      <QueryClientProvider client={container.queryClient}>{children}</QueryClientProvider>
    </ContainerContext.Provider>
  );
}

export function useContainer(): AppContainer {
  const container = useContext(ContainerContext);
  if (container === null) throw new Error('ContainerProvider missing');
  return container;
}

export function useLanguage(): SupportedLanguage {
  const container = useContainer();
  return useStore(container.settings, (s) => s.settings.localeOverride ?? deviceLanguage());
}

function deviceLanguage(): SupportedLanguage {
  const code = getLocales()[0]?.languageCode ?? 'en';
  return isSupportedLanguage(code) ? code : 'en';
}

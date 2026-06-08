import React, { createContext, useContext, type ReactNode } from 'react';
import type { AppContainer } from './appContainer';

const ContainerContext = createContext<AppContainer | null>(null);

export const ContainerProvider = ({
  container,
  children,
}: {
  container: AppContainer;
  children: ReactNode;
}): React.JSX.Element => (
  <ContainerContext.Provider value={container}>{children}</ContainerContext.Provider>
);

export const useContainer = (): AppContainer => {
  const container = useContext(ContainerContext);
  if (container === null) throw new Error('useContainer used outside ContainerProvider');
  return container;
};

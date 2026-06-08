import { useColorScheme } from 'react-native';
import { useStore } from 'zustand';
import { useContainer } from '../container/containerContext';
import { darkTheme, lightTheme, type AppTheme } from './theme';

export const useTheme = (): AppTheme => {
  const container = useContainer();
  const mode = useStore(container.settings, (s) => s.settings.themeMode);
  const system = useColorScheme();
  const resolved = mode === 'system' ? (system ?? 'light') : mode;
  return resolved === 'dark' ? darkTheme : lightTheme;
};

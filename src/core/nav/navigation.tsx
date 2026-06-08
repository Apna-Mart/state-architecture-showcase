import { useStore } from 'zustand';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createStaticNavigation, type StaticParamList } from '@react-navigation/native';
import { useContainer } from '../container/containerContext';
import { userIdOrNull } from '../../features/auth/data/auth';
import { LoginScreen } from '../../features/auth/ui/LoginScreen';
import { HomeScreen } from '../../features/home/ui/HomeScreen';
import { SearchScreen } from '../../features/billers/ui/SearchScreen';
import { CategoryScreen } from '../../features/billers/ui/CategoryScreen';
import { BillFetchScreen } from '../../features/bills/ui/BillFetchScreen';
import { BillReviewScreen } from '../../features/bills/ui/BillReviewScreen';
import { ReceiptScreen } from '../../features/payments/ui/ReceiptScreen';
import { HistoryScreen } from '../../features/payments/ui/HistoryScreen';
import { SettingsScreen } from '../../features/settings/ui/SettingsScreen';

const useIsAuthenticated = (): boolean => {
  const container = useContainer();
  return useStore(container.auth, (s) => userIdOrNull(s.auth) !== null);
};

const useIsGuest = (): boolean => !useIsAuthenticated();

const RootStack = createNativeStackNavigator({
  screenOptions: { headerShown: true },
  groups: {
    Guest: {
      if: useIsGuest,
      screens: {
        Login: { screen: LoginScreen, options: { headerShown: false } },
      },
    },
    App: {
      if: useIsAuthenticated,
      screens: {
        Home: { screen: HomeScreen, options: { headerShown: false } },
        Search: SearchScreen,
        Category: CategoryScreen,
        BillFetch: BillFetchScreen,
        BillReview: BillReviewScreen,
        Receipt: ReceiptScreen,
        History: HistoryScreen,
        Settings: SettingsScreen,
      },
    },
  },
});

type RootParamList = StaticParamList<typeof RootStack>;

declare global {
  namespace ReactNavigation {
    interface RootParamList extends StaticParamList<typeof RootStack> {}
  }
}

export type { RootParamList };
export const Navigation = createStaticNavigation(RootStack);

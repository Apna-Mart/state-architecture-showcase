import React, { useEffect } from 'react';
import { FlatList } from 'react-native';
import { Text } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useNavigation, type StaticScreenProps } from '@react-navigation/native';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { Centered, Loading, PrimaryButton, Screen } from '../../../core/ui/components';
import { BillerListItem } from './BillerListItem';
import { useCategoryScreenData } from './categoryScreenData';
import { assertNever } from '../../../core/async/async';

type Props = StaticScreenProps<{ categoryId: string }>;

export const CategoryScreen = ({ route }: Props): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t } = useTranslation();
  const nav = useNavigation();
  const data = useCategoryScreenData(route.params.categoryId);

  useEffect(() => { container.catalog.getState().ensureLoaded(); }, [container]);

  switch (data.kind) {
    case 'loading':
      return <Screen><Loading /></Screen>;
    case 'error':
      return (
        <Screen>
          <Centered>
            <Text style={{ color: theme.onSurface }}>{t('somethingWentWrong')}</Text>
            <PrimaryButton label={t('retry')} onPress={() => container.catalog.getState().refreshIfStale()} />
          </Centered>
        </Screen>
      );
    case 'loaded':
      return (
        <Screen>
          <FlatList
            data={data.billers}
            keyExtractor={(b) => b.id}
            renderItem={({ item }) => (
              <BillerListItem item={item} onPress={() => nav.navigate('BillFetch', { billerId: item.id })} />
            )}
          />
        </Screen>
      );
    default:
      return assertNever(data);
  }
};

import React, { useEffect } from 'react';
import { FlatList, StyleSheet, Text, TextInput } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useNavigation } from '@react-navigation/native';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { Centered, Loading, PrimaryButton, Screen } from '../../../core/ui/components';
import { BillerListItem } from './BillerListItem';
import { useSearchScreenData } from './searchScreenData';
import { assertNever } from '../../../core/async/async';

export const SearchScreen = (): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t } = useTranslation();
  const nav = useNavigation();
  const data = useSearchScreenData();

  useEffect(() => { container.catalog.getState().ensureLoaded(); }, [container]);

  function renderBody(): React.JSX.Element {
    switch (data.kind) {
      case 'idle':
        return <Centered><Text style={{ color: theme.onSurface }}>{t('typeAtLeastTwoCharacters')}</Text></Centered>;
      case 'searching':
        return <Loading />;
      case 'empty':
        return <Centered><Text style={{ color: theme.onSurface }}>{t('noBillersMatch', { query: data.query })}</Text></Centered>;
      case 'error':
        return (
          <Centered>
            <Text style={{ color: theme.onSurface }}>{t('searchFailed')}</Text>
            <PrimaryButton label={t('retry')} onPress={() => container.search.getState().setQuery(data.query)} />
          </Centered>
        );
      case 'results':
        return (
          <FlatList
            data={data.billers}
            keyExtractor={(b) => b.id}
            renderItem={({ item }) => (
              <BillerListItem item={item} onPress={() => nav.navigate('BillFetch', { billerId: item.id })} />
            )}
          />
        );
      default:
        return assertNever(data);
    }
  }

  return (
    <Screen>
      <TextInput
        autoFocus
        style={[styles.search, { color: theme.onSurface, borderColor: theme.border }]}
        placeholder={t('searchBillers')}
        placeholderTextColor={theme.border}
        onChangeText={(v) => container.search.getState().setQuery(v)}
      />
      {renderBody()}
    </Screen>
  );
};

const styles = StyleSheet.create({
  search: { borderWidth: 1, borderRadius: 8, padding: 12, fontSize: 16, marginBottom: 8 },
});

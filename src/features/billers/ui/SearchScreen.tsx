import { useState } from 'react';
import { ActivityIndicator, FlatList, Text, TextInput, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useRouter } from 'expo-router';
import { s } from '@/core/ui/styles';
import { assertNever } from '@/core/async/async';
import { useSearchScreenData } from './useSearchScreenData';
import { BillerListItem } from './BillerListItem';

export function SearchScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const [query, setQuery] = useState('');
  const data = useSearchScreenData(query);
  return (
    <View style={s.screen}>
      <TextInput style={[s.input, { margin: 12 }]} autoFocus placeholder={t('searchBillers')} value={query} onChangeText={setQuery} />
      {render()}
    </View>
  );

  function render() {
    switch (data.kind) {
      case 'idle': return <View style={s.centered}><Text style={s.mutedText}>{t('typeAtLeastTwoCharacters')}</Text></View>;
      case 'searching': return <View style={s.centered}><ActivityIndicator /></View>;
      case 'empty': return <View style={s.centered}><Text style={s.mutedText}>{t('noBillersMatch', { query: data.query })}</Text></View>;
      case 'error': return <View style={s.centered}><Text style={s.bodyText}>{t('searchFailed')}</Text></View>;
      case 'results': return (
        <FlatList
          data={data.billers}
          keyExtractor={(b) => b.id}
          renderItem={({ item }) => <BillerListItem item={item} onPress={() => router.push(`/biller/${item.id}`)} />}
        />
      );
      default: return assertNever(data);
    }
  }
}

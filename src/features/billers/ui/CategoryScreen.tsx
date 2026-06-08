import { ActivityIndicator, FlatList, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Stack, useRouter } from 'expo-router';
import { s } from '@/core/ui/styles';
import { assertNever } from '@/core/async/async';
import { useCategoryScreenData } from './useCategoryScreenData';
import { BillerListItem } from './BillerListItem';

export function CategoryScreen({ categoryId }: { categoryId: string }) {
  const { t } = useTranslation();
  const router = useRouter();
  const data = useCategoryScreenData(categoryId);
  const title = data.kind === 'loaded' ? data.categoryName : t('billers');
  return (
    <View style={s.screen}>
      <Stack.Screen options={{ title }} />
      {body()}
    </View>
  );

  function body() {
    switch (data.kind) {
      case 'loading': return <View style={s.centered}><ActivityIndicator /></View>;
      case 'error': return <View style={s.centered}><Text style={s.bodyText}>{t('somethingWentWrong')}</Text></View>;
      case 'loaded': return (
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

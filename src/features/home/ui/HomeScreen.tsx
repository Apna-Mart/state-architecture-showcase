import { ActivityIndicator, FlatList, Pressable, ScrollView, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useRouter } from 'expo-router';
import { useContainer, useLanguage } from '@/core/containerContext';
import { formatPaise } from '@/core/format/formats';
import { Icon } from '@/core/ui/Icon';
import { palette, s } from '@/core/ui/styles';
import { spacing } from '@/core/theme/theme';
import { dueLabel } from '@/l10n/dueLabel';
import { useHomeScreenData } from './useHomeScreenData';

export function HomeScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const container = useContainer();
  const language = useLanguage();
  const data = useHomeScreenData();
  const logout = () => container.auth.getState().logout();
  return (
    <View style={s.screen}>
      <View style={[s.row, { justifyContent: 'flex-end', padding: spacing.sm }]}>
        <Pressable accessibilityRole="button" onPress={() => router.push('/search')}><Icon name="search" size={24} color={palette.text} /></Pressable>
        <Pressable accessibilityRole="button" onPress={() => router.push('/history')}><Icon name="receipt" size={24} color={palette.text} /></Pressable>
        <Pressable accessibilityRole="button" onPress={() => router.push('/settings')}><Icon name="settings" size={24} color={palette.text} /></Pressable>
        <Pressable accessibilityRole="button" onPress={logout}><Icon name="log-out" size={24} color={palette.text} /></Pressable>
      </View>
      <ScrollView>
        {data.reminders.kind === 'loading' ? <ActivityIndicator style={{ margin: spacing.md }} /> : data.reminders.items.length > 0 && (
          <View>
            <Text style={s.sectionTitle}>{t('upcomingBills')}</Text>
            <FlatList
              horizontal
              data={data.reminders.items}
              keyExtractor={(d) => `${d.billerId}|${d.account}`}
              contentContainerStyle={{ padding: spacing.sm }}
              renderItem={({ item }) => (
                <Pressable accessibilityRole="button" style={[s.card, { width: 160, marginRight: spacing.sm }]} onPress={() => router.push(`/biller/${item.billerId}/review?account=${encodeURIComponent(item.account)}`)}>
                  <Text numberOfLines={1} style={s.bodyText}>{item.billerName}</Text>
                  <Text style={s.bodyText}>{formatPaise(item.amountPaise, language)}</Text>
                  <Text style={{ color: item.dueInDays < 0 ? palette.error : palette.secondary }}>{dueLabel(t, item.dueInDays)}</Text>
                </Pressable>
              )}
            />
          </View>
        )}
        {data.savedBillers.kind === 'loaded' && data.savedBillers.items.length > 0 && (
          <View>
            <Text style={s.sectionTitle}>{t('savedBillers')}</Text>
            {data.savedBillers.items.map((item) => (
              <Pressable
                key={`${item.billerId}|${item.account}`}
                accessibilityRole="button"
                style={s.listItem}
                onPress={() => router.push(item.openAmount ? `/biller/${item.billerId}` : `/biller/${item.billerId}/review?account=${encodeURIComponent(item.account)}`)}
              >
                <View>
                  <Text style={s.bodyText}>{item.nickname}</Text>
                  <Text style={s.mutedText}>{item.billerName} · {item.account}</Text>
                </View>
              </Pressable>
            ))}
          </View>
        )}
        <Text style={s.sectionTitle}>{t('payABill')}</Text>
        {categoriesBody()}
      </ScrollView>
    </View>
  );

  function categoriesBody() {
    const c = data.categories;
    if (c.kind === 'loading') return <ActivityIndicator style={{ margin: spacing.md }} />;
    if (c.kind === 'error') return <Text style={[s.bodyText, s.padded]}>{t('somethingWentWrong')}</Text>;
    return (
      <View style={{ flexDirection: 'row', flexWrap: 'wrap', padding: spacing.sm }}>
        {c.items.map((item) => (
          <Pressable key={item.id} accessibilityRole="button" style={[s.card, { width: '30%', margin: '1.5%', alignItems: 'center' }]} onPress={() => router.push(`/category/${item.id}`)}>
            <Icon name={item.icon} size={28} color={palette.primary} />
            <Text style={[s.mutedText, { textAlign: 'center', marginTop: spacing.xs }]}>{item.name}</Text>
          </Pressable>
        ))}
      </View>
    );
  }
}

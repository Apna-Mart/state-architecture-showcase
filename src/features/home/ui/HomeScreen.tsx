import React, { useEffect } from 'react';
import { Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useNavigation } from '@react-navigation/native';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { Centered, PrimaryButton, Screen } from '../../../core/ui/components';
import { formatPaise } from '../../../core/format/formats';
import { dueLabel } from '../../../l10n/dueLabel';
import { useStore } from 'zustand';
import { useHomeScreenData } from './homeScreenData';
import type { CategoryItemData, DueBillItemData, SavedBillerItemData } from './homeScreenData';

export const HomeScreen = (): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t, i18n } = useTranslation();
  const nav = useNavigation();
  const language = useStore(container.locale, (s) => s.language);
  const data = useHomeScreenData();

  useEffect(() => {
    container.catalog.getState().ensureLoaded();
    container.dueBills.getState().ensureLoaded();
  }, [container]);

  return (
    <Screen>
      <View style={styles.appbar}>
        <Text style={[styles.appTitle, { color: theme.onSurface }]}>{t('appTitle')}</Text>
        <View style={styles.actions}>
          <Action label="search" onPress={() => nav.navigate('Search')} color={theme.primary} />
          <Action label="history" onPress={() => nav.navigate('History')} color={theme.primary} />
          <Action label="settings" onPress={() => nav.navigate('Settings')} color={theme.primary} />
          <Action label="logout" onPress={() => container.auth.getState().logout()} color={theme.error} />
        </View>
      </View>
      <ScrollView contentContainerStyle={styles.scroll}>
        {data.reminders.kind === 'loaded' && data.reminders.items.length > 0 && (
          <Section title={t('upcomingBills')} color={theme.onSurface}>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.row}>
              {data.reminders.items.map((item) => (
                <DueBillCard
                  key={`${item.billerId}-${item.account}`}
                  item={item}
                  locale={language}
                  label={dueLabel(i18n.t.bind(i18n), item.dueInDays)}
                  danger={item.dueInDays < 0}
                  onPress={() => nav.navigate('BillReview', { billerId: item.billerId, account: item.account })}
                />
              ))}
            </ScrollView>
          </Section>
        )}
        {data.savedBillers.kind === 'loaded' && data.savedBillers.items.length > 0 && (
          <Section title={t('savedBillers')} color={theme.onSurface}>
            {data.savedBillers.items.map((item) => (
              <SavedBillerTile
                key={`${item.billerId}-${item.account}`}
                item={item}
                color={theme.onSurface}
                onPress={() =>
                  item.openAmount
                    ? nav.navigate('BillFetch', { billerId: item.billerId })
                    : nav.navigate('BillReview', { billerId: item.billerId, account: item.account })
                }
              />
            ))}
          </Section>
        )}
        {data.categories.kind === 'loading' && <Centered><Text style={{ color: theme.onSurface }}>…</Text></Centered>}
        {data.categories.kind === 'error' && (
          <Centered>
            <Text style={{ color: theme.onSurface }}>{t('somethingWentWrong')}</Text>
            <PrimaryButton label={t('retry')} onPress={() => container.catalog.getState().refreshIfStale()} />
          </Centered>
        )}
        {data.categories.kind === 'loaded' && (
          <Section title={t('payABill')} color={theme.onSurface}>
            <View style={styles.grid}>
              {data.categories.items.map((item) => (
                <CategoryTile key={item.id} item={item} color={theme.onSurface} surface={theme.surface} onPress={() => nav.navigate('Category', { categoryId: item.id })} />
              ))}
            </View>
          </Section>
        )}
      </ScrollView>
    </Screen>
  );
};

const Action = ({ label, onPress, color }: { label: string; onPress: () => void; color: string }): React.JSX.Element => (
  <Pressable accessibilityRole="button" onPress={onPress}><Text style={[styles.action, { color }]}>{label}</Text></Pressable>
);

const Section = ({ title, color, children }: { title: string; color: string; children: React.ReactNode }): React.JSX.Element => (
  <View style={styles.section}>
    <Text style={[styles.sectionTitle, { color }]}>{title}</Text>
    {children}
  </View>
);

const DueBillCard = ({ item, locale, label, danger, onPress }: { item: DueBillItemData; locale: string; label: string; danger: boolean; onPress: () => void }): React.JSX.Element => {
  const theme = useTheme();
  return (
    <Pressable accessibilityRole="button" onPress={onPress} style={[styles.card, { backgroundColor: theme.surface }]}>
      <Text numberOfLines={1} style={{ color: theme.onSurface }}>{item.billerName}</Text>
      <Text style={[styles.amount, { color: theme.onSurface }]}>{formatPaise(item.amountPaise, locale)}</Text>
      <Text style={{ color: danger ? theme.error : theme.secondary }}>{label}</Text>
    </Pressable>
  );
};

const SavedBillerTile = ({ item, color, onPress }: { item: SavedBillerItemData; color: string; onPress: () => void }): React.JSX.Element => (
  <Pressable accessibilityRole="button" onPress={onPress} style={styles.tile}>
    <Text style={{ color, fontWeight: '600' }}>{item.nickname}</Text>
    <Text style={{ color }}>{`${item.billerName} · ${item.account}`}</Text>
  </Pressable>
);

const CategoryTile = ({ item, color, surface, onPress }: { item: CategoryItemData; color: string; surface: string; onPress: () => void }): React.JSX.Element => (
  <Pressable accessibilityRole="button" onPress={onPress} style={[styles.gridItem, { backgroundColor: surface }]}>
    <Text style={{ color }}>{item.name}</Text>
  </Pressable>
);

const styles = StyleSheet.create({
  appbar: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', paddingVertical: 8 },
  appTitle: { fontSize: 22, fontWeight: '700' },
  actions: { flexDirection: 'row', gap: 12 },
  action: { fontSize: 13 },
  scroll: { paddingBottom: 24, gap: 8 },
  section: { gap: 8, paddingTop: 8 },
  sectionTitle: { fontSize: 16, fontWeight: '700' },
  row: { gap: 12, paddingVertical: 4 },
  card: { width: 160, height: 100, borderRadius: 12, padding: 12, justifyContent: 'center', gap: 4 },
  amount: { fontSize: 18, fontWeight: '700' },
  tile: { paddingVertical: 12, gap: 2 },
  grid: { flexDirection: 'row', flexWrap: 'wrap', gap: 12 },
  gridItem: { width: '30%', aspectRatio: 1, borderRadius: 12, alignItems: 'center', justifyContent: 'center', padding: 8 },
});

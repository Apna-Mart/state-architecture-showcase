import React from 'react';
import { FlatList, Pressable, StyleSheet, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useNavigation } from '@react-navigation/native';
import { useStore } from 'zustand';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { Centered, Screen } from '../../../core/ui/components';
import { formatDate, formatPaise } from '../../../core/format/formats';
import { useHistoryScreenData, type PaymentListItemData } from './historyScreenData';
import type { PaymentStatus } from '../data/payment';
import { assertNever } from '../../../core/async/async';

export const HistoryScreen = (): React.JSX.Element => {
  const theme = useTheme();
  const { t } = useTranslation();
  const data = useHistoryScreenData();
  if (data.kind === 'empty') return <Screen><Centered><Text style={{ color: theme.onSurface }}>{t('noPaymentsYet')}</Text></Centered></Screen>;
  return (
    <Screen>
      <FlatList data={data.items} keyExtractor={(p) => p.id} renderItem={({ item }) => <PaymentRow item={item} />} />
    </Screen>
  );
};

const statusLabel = (t: ReturnType<typeof useTranslation>['t'], status: PaymentStatus): string => {
  switch (status) {
    case 'processing': return t('statusProcessing');
    case 'success': return t('statusSuccess');
    case 'failed': return t('statusFailed');
    default: return assertNever(status);
  }
};

const PaymentRow = ({ item }: { item: PaymentListItemData }): React.JSX.Element => {
  const theme = useTheme();
  const { t } = useTranslation();
  const nav = useNavigation();
  const language = useStore(useContainer().locale, (s) => s.language);
  const color = item.status === 'failed' ? theme.error : item.status === 'success' ? theme.primary : theme.secondary;
  return (
    <Pressable accessibilityRole="button" onPress={() => nav.navigate('Receipt', { paymentId: item.id })} style={styles.row}>
      <View style={styles.left}>
        <Text style={[styles.name, { color: theme.onSurface }]}>{item.billerName}</Text>
        <Text style={{ color: theme.border }}>{`${item.account} · ${formatDate(item.paidAt, language)}`}</Text>
      </View>
      <View style={styles.right}>
        <Text style={[styles.amount, { color: theme.onSurface }]}>{formatPaise(item.amountPaise, language)}</Text>
        <Text style={{ color }}>{statusLabel(t, item.status)}</Text>
      </View>
    </Pressable>
  );
};

const styles = StyleSheet.create({
  row: { flexDirection: 'row', justifyContent: 'space-between', paddingVertical: 14, borderBottomWidth: StyleSheet.hairlineWidth, borderColor: '#0002' },
  left: { gap: 2, flexShrink: 1 },
  right: { alignItems: 'flex-end', gap: 2 },
  name: { fontSize: 16, fontWeight: '500' },
  amount: { fontSize: 16, fontWeight: '700' },
});

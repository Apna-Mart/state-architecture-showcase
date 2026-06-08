import { FlatList, Pressable, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Stack, useRouter } from 'expo-router';
import { useLanguage } from '@/core/containerContext';
import { formatDate, formatPaise } from '@/core/format/formats';
import { palette, s } from '@/core/ui/styles';
import { assertNever } from '@/core/async/async';
import type { PaymentStatus } from '../data/payment';
import { useHistoryScreenData } from './useHistoryScreenData';

export function HistoryScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const language = useLanguage();
  const data = useHistoryScreenData();
  const statusLabel = (status: PaymentStatus): [string, string] =>
    status === 'processing' ? [t('statusProcessing'), palette.secondary]
    : status === 'success' ? [t('statusSuccess'), palette.primary]
    : [t('statusFailed'), palette.error];
  return (
    <View style={s.screen}>
      <Stack.Screen options={{ title: t('paymentHistory') }} />
      {data.kind === 'empty' ? (
        <View style={s.centered}><Text style={s.mutedText}>{t('noPaymentsYet')}</Text></View>
      ) : data.kind === 'loaded' ? (
        <FlatList
          data={data.items}
          keyExtractor={(p) => p.id}
          renderItem={({ item }) => {
            const [label, color] = statusLabel(item.status);
            return (
              <Pressable accessibilityRole="button" style={s.listItem} onPress={() => router.push(`/payment/${item.id}`)}>
                <View>
                  <Text style={s.bodyText}>{item.billerName}</Text>
                  <Text style={s.mutedText}>{item.account} · {formatDate(new Date(item.paidAt), language)}</Text>
                </View>
                <View style={{ alignItems: 'flex-end' }}>
                  <Text style={s.bodyText}>{formatPaise(item.amountPaise, language)}</Text>
                  <Text style={{ color }}>{label}</Text>
                </View>
              </Pressable>
            );
          }}
        />
      ) : assertNever(data)}
    </View>
  );
}

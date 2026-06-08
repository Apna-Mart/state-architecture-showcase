import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useNavigation, type StaticScreenProps } from '@react-navigation/native';
import { useStore } from 'zustand';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { Centered, Loading, PrimaryButton, Screen } from '../../../core/ui/components';
import { formatDate, formatPaise } from '../../../core/format/formats';
import { useReceiptScreenData } from './receiptScreenData';
import { assertNever } from '../../../core/async/async';

type Props = StaticScreenProps<{ paymentId: string }>;

export const ReceiptScreen = ({ route }: Props): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t } = useTranslation();
  const nav = useNavigation();
  const language = useStore(container.locale, (s) => s.language);
  const data = useReceiptScreenData(route.params.paymentId);

  switch (data.kind) {
    case 'notFound':
      return <Screen><Centered><Text style={{ color: theme.onSurface }}>{t('paymentNotFound')}</Text></Centered></Screen>;
    case 'processing':
      return (
        <Screen>
          <Centered>
            <Loading />
            <Text style={{ color: theme.onSurface }}>{t('payingAmountTo', { amount: formatPaise(data.amountPaise, language), billerName: data.billerName })}</Text>
          </Centered>
        </Screen>
      );
    case 'success':
      return (
        <Screen>
          <Text style={[styles.big, { color: theme.primary }]}>{formatPaise(data.amountPaise, language)}</Text>
          <Text style={[styles.center, { color: theme.onSurface }]}>{t('paidTo', { billerName: data.billerName })}</Text>
          <View style={[styles.card, { backgroundColor: theme.surface }]}>
            <Text style={{ color: theme.onSurface }}>{t('receiptNumber', { paymentId: data.paymentId })}</Text>
            <Text style={{ color: theme.onSurface }}>{t('accountValue', { account: data.account })}</Text>
            <Text style={{ color: theme.onSurface }}>{t('dateValue', { date: formatDate(data.paidAt, language) })}</Text>
          </View>
          <View style={styles.spacer} />
          {data.canSaveBiller && (
            <PrimaryButton
              label={t('saveBiller')}
              onPress={() => void container.savedBillers.getState().save({ billerId: data.billerId, account: data.account, nickname: data.billerName })}
            />
          )}
          <PrimaryButton label={t('done')} onPress={() => nav.navigate('Home')} />
        </Screen>
      );
    case 'failed':
      return (
        <Screen>
          <Text style={[styles.center, styles.big, { color: theme.error }]}>{t('paymentFailedSummary', { amount: formatPaise(data.amountPaise, language), billerName: data.billerName })}</Text>
          <View style={styles.spacer} />
          <PrimaryButton
            label={t('retryPayment')}
            onPress={() => void container.payments.getState().pay({ billerId: data.billerId, billerName: data.billerName, categoryId: data.categoryId, account: data.account, amountPaise: data.amountPaise })}
          />
          <Text accessibilityRole="button" onPress={() => nav.navigate('Home')} style={[styles.link, { color: theme.primary }]}>{t('backToHome')}</Text>
        </Screen>
      );
    default:
      return assertNever(data);
  }
};

const styles = StyleSheet.create({
  big: { fontSize: 28, fontWeight: '700', textAlign: 'center', marginTop: 24 },
  center: { textAlign: 'center' },
  card: { borderRadius: 12, padding: 16, gap: 4, marginTop: 16 },
  spacer: { flex: 1 },
  link: { textAlign: 'center', paddingVertical: 12 },
});

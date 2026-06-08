import { ActivityIndicator, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Stack, useRouter } from 'expo-router';
import { useContainer, useLanguage } from '@/core/containerContext';
import { formatDate, formatPaise } from '@/core/format/formats';
import { assertNever } from '@/core/async/async';
import { Icon } from '@/core/ui/Icon';
import { palette, s } from '@/core/ui/styles';
import { spacing } from '@/core/theme/theme';
import { PrimaryButton } from '@/core/ui/PrimaryButton';
import { useReceiptScreenData } from './useReceiptScreenData';

export function ReceiptScreen({ paymentId }: { paymentId: string }) {
  const { t } = useTranslation();
  const router = useRouter();
  const language = useLanguage();
  const container = useContainer();
  const data = useReceiptScreenData(paymentId);
  return (
    <View style={[s.screen, s.padded]}>
      <Stack.Screen options={{ title: t('payment') }} />
      {body()}
    </View>
  );

  function body() {
    switch (data.kind) {
      case 'notFound':
        return <View style={s.centered}><Text style={s.bodyText}>{t('paymentNotFound')}</Text></View>;
      case 'processing':
        return (
          <View style={s.centered}>
            <ActivityIndicator />
            <Text style={[s.bodyText, { marginTop: spacing.md }]}>{t('payingAmountTo', { amount: formatPaise(data.amountPaise, language), billerName: data.billerName })}</Text>
          </View>
        );
      case 'success':
        return (
          <View style={{ flex: 1 }}>
            <Icon name="checkmark-circle" size={64} color={palette.primary} style={{ alignSelf: 'center', marginTop: spacing.lg }} />
            <Text style={[s.amount, { textAlign: 'center' }]}>{formatPaise(data.amountPaise, language)}</Text>
            <Text style={[s.bodyText, { textAlign: 'center' }]}>{t('paidTo', { billerName: data.billerName })}</Text>
            <View style={[s.card, { marginTop: spacing.md }]}>
              <Text style={s.bodyText}>{t('receiptNumber', { paymentId: data.paymentId })}</Text>
              <Text style={s.bodyText}>{t('accountValue', { account: data.account })}</Text>
              <Text style={s.bodyText}>{t('dateValue', { date: formatDate(new Date(data.paidAt), language) })}</Text>
            </View>
            <View style={{ flex: 1 }} />
            {data.canSaveBiller && (
              <View style={{ marginBottom: spacing.sm }}>
                <PrimaryButton label={t('saveBiller')} onPress={() => container.savedBillers.getState().save({ billerId: data.billerId, account: data.account, nickname: data.billerName })} />
              </View>
            )}
            <PrimaryButton label={t('done')} onPress={() => router.replace('/')} />
          </View>
        );
      case 'failed':
        return (
          <View style={{ flex: 1 }}>
            <Icon name="alert-circle" size={64} color={palette.error} style={{ alignSelf: 'center', marginTop: spacing.lg }} />
            <Text style={[s.bodyText, { textAlign: 'center' }]}>{t('paymentFailedSummary', { amount: formatPaise(data.amountPaise, language), billerName: data.billerName })}</Text>
            <View style={{ flex: 1 }} />
            <View style={{ marginBottom: spacing.sm }}>
              <PrimaryButton label={t('retryPayment')} onPress={() => container.payments.getState().pay({ billerId: data.billerId, billerName: data.billerName, categoryId: data.categoryId, account: data.account, amountPaise: data.amountPaise })} />
            </View>
            <Text style={[s.mutedText, { textAlign: 'center' }]} onPress={() => router.replace('/')}>{t('backToHome')}</Text>
          </View>
        );
      default:
        return assertNever(data);
    }
  }
}

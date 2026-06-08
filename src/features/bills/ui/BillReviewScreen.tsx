import { ActivityIndicator, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Stack } from 'expo-router';
import { useContainer, useLanguage } from '@/core/containerContext';
import { formatPaise } from '@/core/format/formats';
import { s } from '@/core/ui/styles';
import { spacing } from '@/core/theme/theme';
import { PrimaryButton } from '@/core/ui/PrimaryButton';
import { dueLabel } from '@/l10n/dueLabel';
import { useBillReviewScreenData } from './useBillReviewScreenData';

type Props = { billerId: string; account: string; amountPaise: number | null };

export function BillReviewScreen({ billerId, account, amountPaise }: Props) {
  const { t } = useTranslation();
  const language = useLanguage();
  const container = useContainer();
  const data = useBillReviewScreenData({ billerId, account, amountPaise });
  return (
    <View style={s.screen}>
      <Stack.Screen options={{ title: t('reviewAndPay') }} />
      {body()}
    </View>
  );

  function body() {
    if (data.kind === 'loading') return <View style={s.centered}><ActivityIndicator /></View>;
    if (data.kind === 'error') return <View style={s.centered}><Text style={s.bodyText}>{t('somethingWentWrong')}</Text></View>;
    return (
      <View style={[s.padded, { flex: 1 }]}>
        <View style={s.card}>
          <Text style={s.title}>{data.billerName}</Text>
          <Text style={s.bodyText}>{t('accountValue', { account: data.account })}</Text>
          {data.customerName !== null && <Text style={s.bodyText}>{t('nameValue', { name: data.customerName })}</Text>}
          {data.dueInDays !== null && <Text style={s.bodyText}>{dueLabel(t, data.dueInDays)}</Text>}
          <Text style={[s.amount, { marginTop: spacing.md }]}>{formatPaise(data.amountPaise, language)}</Text>
        </View>
        <View style={{ flex: 1 }} />
        <PrimaryButton
          label={t('payAmount', { amount: formatPaise(data.amountPaise, language) })}
          disabled={!data.canPay}
          loading={data.paying}
          onPress={() => container.payments.getState().pay({ billerId: data.billerId, billerName: data.billerName, categoryId: data.categoryId, account: data.account, amountPaise: data.amountPaise })}
        />
      </View>
    );
  }
}

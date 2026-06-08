import React, { useEffect } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { type StaticScreenProps } from '@react-navigation/native';
import { useContainer } from '../../../core/container/containerContext';
import { useStore } from 'zustand';
import { useTheme } from '../../../core/theme/useTheme';
import { Loading, PrimaryButton, Screen } from '../../../core/ui/components';
import { formatPaise } from '../../../core/format/formats';
import { dueLabel } from '../../../l10n/dueLabel';
import { useBillReviewScreenData } from './billReviewScreenData';

type Props = StaticScreenProps<{ billerId: string; account: string; amountPaise?: number }>;

export const BillReviewScreen = ({ route }: Props): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t, i18n } = useTranslation();
  const language = useStore(container.locale, (s) => s.language);
  const params = {
    billerId: route.params.billerId,
    account: route.params.account,
    amountPaise: route.params.amountPaise ?? null,
  };
  const data = useBillReviewScreenData(params);

  useEffect(() => {
    if (params.amountPaise === null) container.bills.getState().ensureBill(params.billerId, params.account);
  }, [container, params.amountPaise, params.billerId, params.account]);

  if (data.kind === 'loading') return <Screen><Loading /></Screen>;
  if (data.kind === 'error') return <Screen><Text style={{ color: theme.onSurface }}>{t('somethingWentWrong')}</Text></Screen>;

  return (
    <Screen>
      <View style={[styles.card, { backgroundColor: theme.surface }]}>
        <Text style={[styles.title, { color: theme.onSurface }]}>{data.billerName}</Text>
        <Text style={{ color: theme.onSurface }}>{t('accountValue', { account: data.account })}</Text>
        {data.customerName !== null && <Text style={{ color: theme.onSurface }}>{t('nameValue', { name: data.customerName })}</Text>}
        {data.dueInDays !== null && <Text style={{ color: theme.onSurface }}>{dueLabel(i18n.t.bind(i18n), data.dueInDays)}</Text>}
        <Text style={[styles.amount, { color: theme.onSurface }]}>{formatPaise(data.amountPaise, language)}</Text>
      </View>
      <View style={styles.spacer} />
      <PrimaryButton
        label={t('payAmount', { amount: formatPaise(data.amountPaise, language) })}
        busy={data.paying}
        disabled={!data.canPay}
        onPress={() =>
          void container.payments.getState().pay({
            billerId: data.billerId,
            billerName: data.billerName,
            categoryId: data.categoryId,
            account: data.account,
            amountPaise: data.amountPaise,
          })
        }
      />
    </Screen>
  );
};

const styles = StyleSheet.create({
  card: { borderRadius: 12, padding: 16, gap: 8 },
  title: { fontSize: 20, fontWeight: '700' },
  amount: { fontSize: 26, fontWeight: '700', marginTop: 8 },
  spacer: { flex: 1 },
});

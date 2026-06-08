import React, { useMemo } from 'react';
import { ScrollView, StyleSheet, Text, TextInput } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useNavigation, type StaticScreenProps } from '@react-navigation/native';
import { useStore } from 'zustand';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { Loading, PrimaryButton, Screen } from '../../../core/ui/components';
import { createBillFetchFormStore } from './billFetchFormStore';
import { projectBillFetch } from './billFetchScreenData';
import { parseLocation } from '../../../core/nav/parseLocation';
import { assertNever } from '../../../core/async/async';

type Props = StaticScreenProps<{ billerId: string }>;

export const BillFetchScreen = ({ route }: Props): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t } = useTranslation();
  const nav = useNavigation();
  const formStore = useMemo(createBillFetchFormStore, []);
  const catalog = useStore(container.catalog, (s) => s.catalog);
  const form = useStore(formStore, (s) => s.form);
  const data = projectBillFetch(catalog, route.params.billerId, form);

  switch (data.kind) {
    case 'loading':
      return <Screen><Loading /></Screen>;
    case 'error':
      return <Screen><Text style={{ color: theme.onSurface }}>{t('somethingWentWrong')}</Text></Screen>;
    case 'form':
      return (
        <Screen>
          <ScrollView contentContainerStyle={styles.body}>
            {data.inputs.fields.map((field) => (
              <TextInput
                key={field.key}
                style={[styles.input, { color: theme.onSurface, borderColor: theme.border }]}
                placeholder={field.hint}
                placeholderTextColor={theme.border}
                onChangeText={(v) => formStore.getState().editField(field.key, v)}
              />
            ))}
            {data.inputs.showAmount && (
              <TextInput
                style={[styles.input, { color: theme.onSurface, borderColor: theme.border }]}
                placeholder={t('enterAmount')}
                placeholderTextColor={theme.border}
                keyboardType="decimal-pad"
                onChangeText={(v) => formStore.getState().editAmount(v)}
              />
            )}
            <PrimaryButton
              label={data.submit.action === 'fetchBill' ? t('fetchBill') : t('continueLabel')}
              disabled={data.submit.location === null}
              onPress={() => {
                if (data.submit.location === null) return;
                const target = parseLocation(data.submit.location);
                (nav.navigate as (name: string, params: object | undefined) => void)(target.name, target.params);
              }}
            />
          </ScrollView>
        </Screen>
      );
    default:
      return assertNever(data);
  }
};

const styles = StyleSheet.create({
  body: { gap: 16 },
  input: { borderWidth: 1, borderRadius: 8, padding: 14, fontSize: 16 },
});

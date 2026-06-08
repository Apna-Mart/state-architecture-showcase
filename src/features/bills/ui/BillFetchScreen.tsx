import { ActivityIndicator, ScrollView, Text, TextInput, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Stack, useRouter } from 'expo-router';
import { s } from '@/core/ui/styles';
import { spacing } from '@/core/theme/theme';
import { PrimaryButton } from '@/core/ui/PrimaryButton';
import { useBillFetchFormStore } from './useBillFetchFormStore';
import { useBillFetchScreenData } from './useBillFetchScreenData';

export function BillFetchScreen({ billerId }: { billerId: string }) {
  const { t } = useTranslation();
  const router = useRouter();
  const formStore = useBillFetchFormStore();
  const data = useBillFetchScreenData(billerId, formStore);
  const title = data.kind === 'form' ? data.billerName : t('billDetails');
  return (
    <View style={s.screen}>
      <Stack.Screen options={{ title }} />
      {body()}
    </View>
  );

  function body() {
    if (data.kind === 'loading') return <View style={s.centered}><ActivityIndicator /></View>;
    if (data.kind === 'error') return <View style={s.centered}><Text style={s.bodyText}>{t('somethingWentWrong')}</Text></View>;
    const actions = formStore.getState();
    return (
      <ScrollView contentContainerStyle={s.padded}>
        {data.inputs.fields.map((field) => (
          <View key={field.key} style={{ marginBottom: spacing.md }}>
            <Text style={s.mutedText}>{field.label}</Text>
            <TextInput style={s.input} placeholder={field.hint} onChangeText={(v) => actions.editField(field.key, v)} />
          </View>
        ))}
        {data.inputs.showAmount && (
          <View style={{ marginBottom: spacing.md }}>
            <Text style={s.mutedText}>{t('amountFieldLabel')}</Text>
            <TextInput style={s.input} keyboardType="decimal-pad" placeholder={t('enterAmount')} onChangeText={(v) => actions.editAmount(v)} />
          </View>
        )}
        <PrimaryButton
          label={data.submit.action === 'fetchBill' ? t('fetchBill') : t('continueLabel')}
          disabled={data.submit.location === null}
          onPress={() => data.submit.location && router.push(data.submit.location as never)}
        />
      </ScrollView>
    );
  }
}

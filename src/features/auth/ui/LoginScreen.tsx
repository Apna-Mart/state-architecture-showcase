import { useState } from 'react';
import { Text, TextInput, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useContainer } from '@/core/containerContext';
import { PrimaryButton } from '@/core/ui/PrimaryButton';
import { s } from '@/core/ui/styles';
import { spacing } from '@/core/theme/theme';
import { useLoginScreenData } from './useLoginScreenData';

export function LoginScreen() {
  const { t } = useTranslation();
  const container = useContainer();
  const [phone, setPhone] = useState('');
  const [otp, setOtp] = useState('');
  const data = useLoginScreenData(phone, otp);
  const auth = container.auth.getState();

  if (data.kind === 'phoneEntry') {
    return (
      <View style={[s.screen, s.centered]}>
        <Text style={[s.title, { textAlign: 'center', marginBottom: spacing.xl }]}>{t('appTitle')}</Text>
        <TextInput
          style={[s.input, { alignSelf: 'stretch', marginBottom: spacing.md }]}
          keyboardType="number-pad"
          maxLength={10}
          placeholder={t('mobileNumber')}
          value={phone}
          onChangeText={setPhone}
        />
        <View style={{ alignSelf: 'stretch' }}>
          <PrimaryButton label={t('sendOtp')} disabled={!data.canSend} loading={data.sending} onPress={() => auth.sendOtp(phone)} />
        </View>
      </View>
    );
  }
  return (
    <View style={[s.screen, s.centered]}>
      <Text style={[s.bodyText, { textAlign: 'center', marginBottom: spacing.xl }]}>{t('otpSentTo', { phone: data.phone })}</Text>
      <TextInput
        style={[s.input, { alignSelf: 'stretch', marginBottom: spacing.md }]}
        keyboardType="number-pad"
        maxLength={6}
        placeholder={t('enterOtp')}
        value={otp}
        onChangeText={setOtp}
      />
      <View style={{ alignSelf: 'stretch' }}>
        <PrimaryButton label={t('verify')} disabled={!data.canVerify} loading={data.verifying} onPress={() => auth.verifyOtp(otp)} />
      </View>
      <Text style={[s.mutedText, { marginTop: spacing.md }]} onPress={() => auth.logout()}>{t('changeNumber')}</Text>
    </View>
  );
}

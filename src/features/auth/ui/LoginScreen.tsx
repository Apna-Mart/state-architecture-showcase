import React, { useMemo } from 'react';
import { StyleSheet, Text, TextInput, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useStore } from 'zustand';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { PrimaryButton, Screen } from '../../../core/ui/components';
import { createLoginInputsStore } from './loginInputsStore';
import { projectLogin } from './loginScreenData';

export const LoginScreen = (): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t } = useTranslation();
  const inputs = useMemo(createLoginInputsStore, []);
  const auth = useStore(container.auth, (s) => s.auth);
  const phone = useStore(inputs, (s) => s.phone);
  const otp = useStore(inputs, (s) => s.otp);
  const data = projectLogin(auth, phone, otp);

  return (
    <Screen>
      <View style={styles.body}>
        {data.kind === 'phoneEntry' ? (
          <>
            <Text style={[styles.title, { color: theme.onSurface }]}>{t('appTitle')}</Text>
            <TextInput
              style={[styles.input, { color: theme.onSurface, borderColor: theme.border }]}
              placeholder={t('mobileNumber')}
              placeholderTextColor={theme.border}
              keyboardType="phone-pad"
              maxLength={10}
              onChangeText={(v) => inputs.getState().setPhone(v)}
            />
            <PrimaryButton
              label={t('sendOtp')}
              busy={data.sending}
              disabled={!data.canSend}
              onPress={() => void container.auth.getState().sendOtp(phone)}
            />
          </>
        ) : (
          <>
            <Text style={[styles.subtitle, { color: theme.onSurface }]}>{t('otpSentTo', { phone: data.phone })}</Text>
            <TextInput
              style={[styles.input, { color: theme.onSurface, borderColor: theme.border }]}
              placeholder={t('enterOtp')}
              placeholderTextColor={theme.border}
              keyboardType="number-pad"
              maxLength={6}
              onChangeText={(v) => inputs.getState().setOtp(v)}
            />
            <PrimaryButton
              label={t('verify')}
              busy={data.verifying}
              disabled={!data.canVerify}
              onPress={() => void container.auth.getState().verifyOtp(otp)}
            />
            <Text
              accessibilityRole="button"
              onPress={() => container.auth.getState().logout()}
              style={[styles.link, { color: theme.primary }]}
            >
              {t('changeNumber')}
            </Text>
          </>
        )}
      </View>
    </Screen>
  );
};

const styles = StyleSheet.create({
  body: { flex: 1, justifyContent: 'center', gap: 16 },
  title: { fontSize: 28, fontWeight: '700', textAlign: 'center' },
  subtitle: { fontSize: 18, textAlign: 'center' },
  input: { borderWidth: 1, borderRadius: 8, padding: 14, fontSize: 16 },
  link: { textAlign: 'center', paddingVertical: 8 },
});

import React from 'react';
import { ActivityIndicator, Pressable, StyleSheet, Text, View } from 'react-native';
import { useTheme } from '../theme/useTheme';

export const Screen = ({ children }: { children: React.ReactNode }): React.JSX.Element => {
  const theme = useTheme();
  return <View style={[styles.screen, { backgroundColor: theme.background }]}>{children}</View>;
};

export const PrimaryButton = ({
  label,
  onPress,
  disabled,
  busy,
}: {
  label: string;
  onPress: () => void;
  disabled?: boolean;
  busy?: boolean;
}): React.JSX.Element => {
  const theme = useTheme();
  const off = disabled || busy;
  return (
    <Pressable
      accessibilityRole="button"
      disabled={off}
      onPress={onPress}
      style={[styles.button, { backgroundColor: off ? theme.border : theme.primary }]}
    >
      {busy ? (
        <ActivityIndicator color={theme.onPrimary} />
      ) : (
        <Text style={[styles.buttonLabel, { color: theme.onPrimary }]}>{label}</Text>
      )}
    </Pressable>
  );
};

export const Centered = ({ children }: { children: React.ReactNode }): React.JSX.Element => (
  <View style={styles.centered}>{children}</View>
);

export const Loading = (): React.JSX.Element => {
  const theme = useTheme();
  return (
    <Centered>
      <ActivityIndicator color={theme.primary} size="large" />
    </Centered>
  );
};

const styles = StyleSheet.create({
  screen: { flex: 1, padding: 16 },
  button: { borderRadius: 8, paddingVertical: 14, alignItems: 'center', justifyContent: 'center' },
  buttonLabel: { fontSize: 16, fontWeight: '600' },
  centered: { flex: 1, alignItems: 'center', justifyContent: 'center', padding: 24 },
});

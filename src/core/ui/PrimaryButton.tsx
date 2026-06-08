import { ActivityIndicator, Pressable, Text } from 'react-native';
import { s } from './styles';

type Props = { label: string; onPress: () => void; disabled?: boolean; loading?: boolean };

export function PrimaryButton({ label, onPress, disabled = false, loading = false }: Props) {
  return (
    <Pressable
      accessibilityRole="button"
      disabled={disabled || loading}
      onPress={onPress}
      style={[s.primaryButton, (disabled || loading) && s.primaryButtonDisabled]}
    >
      {loading ? <ActivityIndicator color="#fff" /> : <Text style={s.primaryButtonText}>{label}</Text>}
    </Pressable>
  );
}

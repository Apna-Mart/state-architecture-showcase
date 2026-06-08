import { Text } from 'react-native';

const glyphs: Record<string, string> = {
  search: '🔍',
  receipt: '🧾',
  settings: '⚙️',
  'log-out': '⏻',
  'checkmark-circle': '✅',
  'alert-circle': '⚠️',
  checkmark: '✓',
  flash: '⚡',
  water: '💧',
  flame: '🔥',
  cube: '📦',
  'phone-portrait': '📱',
  card: '💳',
  tv: '📺',
  wifi: '📶',
  call: '📞',
  car: '🚗',
  'card-outline': '💳',
  'shield-checkmark': '🛡️',
  business: '🏢',
  school: '🎓',
  location: '📍',
};

type Props = { name: string; size?: number; color?: string; style?: object };

export function Icon({ name, size = 24, color, style }: Props) {
  return <Text style={[{ fontSize: size, color }, style]}>{glyphs[name] ?? '•'}</Text>;
}

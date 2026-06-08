import { StyleSheet } from 'react-native';
import { lightPalette, radii, spacing } from '@/core/theme/theme';

export const palette = lightPalette;

export const s = StyleSheet.create({
  screen: { flex: 1, backgroundColor: palette.background },
  centered: { flex: 1, alignItems: 'center', justifyContent: 'center', padding: spacing.lg },
  padded: { padding: spacing.md },
  card: { backgroundColor: palette.surface, borderRadius: radii.card, padding: spacing.md, borderWidth: 1, borderColor: palette.border },
  title: { fontSize: 22, fontWeight: '700', color: palette.text },
  sectionTitle: { fontSize: 16, fontWeight: '700', color: palette.text, paddingHorizontal: spacing.md, paddingVertical: spacing.sm },
  bodyText: { fontSize: 14, color: palette.text },
  mutedText: { fontSize: 13, color: palette.textMuted },
  input: { borderWidth: 1, borderColor: palette.border, borderRadius: radii.control, padding: spacing.md, fontSize: 16, color: palette.text },
  primaryButton: { backgroundColor: palette.primary, borderRadius: radii.control, padding: spacing.md, alignItems: 'center' },
  primaryButtonDisabled: { backgroundColor: palette.border },
  primaryButtonText: { color: palette.onPrimary, fontWeight: '700', fontSize: 16 },
  listItem: { padding: spacing.md, borderBottomWidth: 1, borderBottomColor: palette.border, flexDirection: 'row', justifyContent: 'space-between' },
  row: { flexDirection: 'row', alignItems: 'center', gap: spacing.sm },
  amount: { fontSize: 26, fontWeight: '700', color: palette.text },
});

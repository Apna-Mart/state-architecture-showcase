import React from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useStore } from 'zustand';
import { useContainer } from '../../../core/container/containerContext';
import { useTheme } from '../../../core/theme/useTheme';
import { Screen } from '../../../core/ui/components';
import type { ThemeModeSetting } from '../data/appSettings';

const LANGUAGES: ReadonlyArray<{ locale: string | null; name: string }> = [
  { locale: null, name: 'systemDefault' },
  { locale: 'en', name: 'English' },
  { locale: 'hi', name: 'हिन्दी' },
  { locale: 'ar', name: 'العربية' },
];
const THEMES: ReadonlyArray<{ mode: ThemeModeSetting; label: string }> = [
  { mode: 'system', label: 'systemDefault' },
  { mode: 'light', label: 'themeLight' },
  { mode: 'dark', label: 'themeDark' },
];

export const SettingsScreen = (): React.JSX.Element => {
  const container = useContainer();
  const theme = useTheme();
  const { t } = useTranslation();
  const settings = useStore(container.settings, (s) => s.settings);

  return (
    <Screen>
      <Text style={[styles.section, { color: theme.onSurface }]}>{t('language')}</Text>
      {LANGUAGES.map((lang) => (
        <Row
          key={lang.locale ?? 'system'}
          label={lang.locale === null ? t('systemDefault') : lang.name}
          selected={settings.localeOverride === lang.locale}
          color={theme.onSurface}
          tint={theme.primary}
          onPress={() => void container.settings.getState().setLocale(lang.locale)}
        />
      ))}
      <Text style={[styles.section, { color: theme.onSurface }]}>{t('theme')}</Text>
      <View style={styles.segment}>
        {THEMES.map((opt) => (
          <Pressable
            key={opt.mode}
            accessibilityRole="button"
            onPress={() => void container.settings.getState().setThemeMode(opt.mode)}
            style={[styles.segmentItem, { borderColor: theme.primary, backgroundColor: settings.themeMode === opt.mode ? theme.primary : 'transparent' }]}
          >
            <Text style={{ color: settings.themeMode === opt.mode ? theme.onPrimary : theme.primary }}>{t(opt.label)}</Text>
          </Pressable>
        ))}
      </View>
    </Screen>
  );
};

const Row = ({ label, selected, color, tint, onPress }: { label: string; selected: boolean; color: string; tint: string; onPress: () => void }): React.JSX.Element => (
  <Pressable accessibilityRole="button" onPress={onPress} style={styles.row}>
    <Text style={{ color }}>{label}</Text>
    {selected && <Text style={{ color: tint }}>✓</Text>}
  </Pressable>
);

const styles = StyleSheet.create({
  section: { fontSize: 16, fontWeight: '700', marginTop: 16, marginBottom: 8 },
  row: { flexDirection: 'row', justifyContent: 'space-between', paddingVertical: 14 },
  segment: { flexDirection: 'row', gap: 8 },
  segmentItem: { flex: 1, borderWidth: 1, borderRadius: 8, paddingVertical: 10, alignItems: 'center' },
});

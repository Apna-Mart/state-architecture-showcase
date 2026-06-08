import { Pressable, ScrollView, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Stack } from 'expo-router';
import { useStore } from 'zustand';
import { useContainer } from '@/core/containerContext';
import type { SupportedLanguage } from '@/core/format/localeConfigs';
import type { ThemeMode } from '../data/appSettings';
import { Icon } from '@/core/ui/Icon';
import { palette, s } from '@/core/ui/styles';
import { spacing } from '@/core/theme/theme';

const languages: { code: SupportedLanguage; name: string }[] = [
  { code: 'en', name: 'English' },
  { code: 'hi', name: 'हिन्दी' },
  { code: 'ar', name: 'العربية' },
];

export function SettingsScreen() {
  const { t } = useTranslation();
  const container = useContainer();
  const settings = useStore(container.settings, (st) => st.settings);
  const actions = container.settings.getState();
  const themes: { mode: ThemeMode; label: string }[] = [
    { mode: 'system', label: t('systemDefault') },
    { mode: 'light', label: t('themeLight') },
    { mode: 'dark', label: t('themeDark') },
  ];
  return (
    <ScrollView style={s.screen}>
      <Stack.Screen options={{ title: t('settings') }} />
      <Text style={s.sectionTitle}>{t('language')}</Text>
      <LanguageRow name={t('systemDefault')} selected={settings.localeOverride === null} onPress={() => actions.setLocale(null)} />
      {languages.map((l) => (
        <LanguageRow key={l.code} name={l.name} selected={settings.localeOverride === l.code} onPress={() => actions.setLocale(l.code)} />
      ))}
      <Text style={s.sectionTitle}>{t('theme')}</Text>
      <View style={[s.row, { padding: spacing.md }]}>
        {themes.map((th) => (
          <Pressable
            key={th.mode}
            accessibilityRole="button"
            onPress={() => actions.setThemeMode(th.mode)}
            style={[s.card, { flex: 1, alignItems: 'center' }, settings.themeMode === th.mode && { borderColor: palette.primary, borderWidth: 2 }]}
          >
            <Text style={s.bodyText}>{th.label}</Text>
          </Pressable>
        ))}
      </View>
    </ScrollView>
  );
}

function LanguageRow({ name, selected, onPress }: { name: string; selected: boolean; onPress: () => void }) {
  return (
    <Pressable accessibilityRole="button" style={s.listItem} onPress={onPress}>
      <Text style={s.bodyText}>{name}</Text>
      {selected && <Icon name="checkmark" size={20} color={palette.primary} />}
    </Pressable>
  );
}

import { I18nManager } from 'react-native';

export function applyRtl(language: string): void {
  const shouldRtl = language === 'ar';
  if (I18nManager.isRTL !== shouldRtl) I18nManager.forceRTL(shouldRtl);
}

import React from 'react';
import { Pressable, StyleSheet, Text } from 'react-native';
import { useTheme } from '../../../core/theme/useTheme';
import type { BillerListItemData } from './billerListItemData';

export const BillerListItem = ({ item, onPress }: { item: BillerListItemData; onPress: () => void }): React.JSX.Element => {
  const theme = useTheme();
  return (
    <Pressable accessibilityRole="button" onPress={onPress} style={styles.row}>
      <Text style={[styles.name, { color: theme.onSurface }]}>{item.name}</Text>
      <Text style={{ color: theme.border }}>{item.categoryName}</Text>
    </Pressable>
  );
};

const styles = StyleSheet.create({
  row: { paddingVertical: 14, borderBottomWidth: StyleSheet.hairlineWidth, borderColor: '#0002' },
  name: { fontSize: 16, fontWeight: '500' },
});

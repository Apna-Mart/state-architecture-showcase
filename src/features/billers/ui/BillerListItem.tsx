import { Pressable, Text, View } from 'react-native';
import { s } from '@/core/ui/styles';
import type { BillerListItemData } from './billerListItemData';

export function BillerListItem({ item, onPress }: { item: BillerListItemData; onPress: () => void }) {
  return (
    <Pressable accessibilityRole="button" style={s.listItem} onPress={onPress}>
      <View>
        <Text style={s.bodyText}>{item.name}</Text>
        <Text style={s.mutedText}>{item.categoryName}</Text>
      </View>
    </Pressable>
  );
}

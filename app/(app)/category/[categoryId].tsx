import { useLocalSearchParams } from 'expo-router';
import { CategoryScreen } from '@/features/billers/ui/CategoryScreen';

export default function CategoryRoute() {
  const { categoryId } = useLocalSearchParams<{ categoryId: string }>();
  return <CategoryScreen categoryId={categoryId} />;
}

import { useLocalSearchParams } from 'expo-router';
import { BillFetchScreen } from '@/features/bills/ui/BillFetchScreen';

export default function BillFetchRoute() {
  const { billerId } = useLocalSearchParams<{ billerId: string }>();
  return <BillFetchScreen billerId={billerId} />;
}

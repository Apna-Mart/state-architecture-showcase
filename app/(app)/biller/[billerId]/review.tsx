import { useLocalSearchParams } from 'expo-router';
import { BillReviewScreen } from '@/features/bills/ui/BillReviewScreen';

export default function ReviewRoute() {
  const { billerId, account, amount } = useLocalSearchParams<{ billerId: string; account?: string; amount?: string }>();
  return <BillReviewScreen billerId={billerId} account={account ?? ''} amountPaise={amount ? Number(amount) : null} />;
}

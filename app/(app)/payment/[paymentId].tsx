import { useLocalSearchParams } from 'expo-router';
import { ReceiptScreen } from '@/features/payments/ui/ReceiptScreen';

export default function ReceiptRoute() {
  const { paymentId } = useLocalSearchParams<{ paymentId: string }>();
  return <ReceiptScreen paymentId={paymentId} />;
}

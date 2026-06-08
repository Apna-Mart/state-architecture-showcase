import { Redirect, Stack } from 'expo-router';
import { useStore } from 'zustand';
import { useContainer } from '@/core/containerContext';
import { userIdOrNull } from '@/features/auth/data/auth';

export default function AppLayout() {
  const container = useContainer();
  const authed = useStore(container.auth, (s) => userIdOrNull(s.auth) !== null);
  if (!authed) return <Redirect href="/login" />;
  return <Stack screenOptions={{ headerShown: true }} />;
}

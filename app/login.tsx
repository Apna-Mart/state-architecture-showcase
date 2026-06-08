import { Redirect } from 'expo-router';
import { useStore } from 'zustand';
import { useContainer } from '@/core/containerContext';
import { userIdOrNull } from '@/features/auth/data/auth';
import { LoginScreen } from '@/features/auth/ui/LoginScreen';

export default function LoginRoute() {
  const container = useContainer();
  const authed = useStore(container.auth, (s) => userIdOrNull(s.auth) !== null);
  if (authed) return <Redirect href="/" />;
  return <LoginScreen />;
}

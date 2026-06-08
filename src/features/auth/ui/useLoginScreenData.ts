import { useStore } from 'zustand';
import { useContainer } from '@/core/containerContext';
import { projectLogin } from './loginProjection';
import type { LoginScreenData } from './loginScreenData';

export function useLoginScreenData(phoneInput: string, otpInput: string): LoginScreenData {
  const container = useContainer();
  const auth = useStore(container.auth, (s) => s.auth);
  return projectLogin(auth, phoneInput, otpInput);
}

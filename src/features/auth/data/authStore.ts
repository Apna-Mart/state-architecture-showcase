import { createStore, type StoreApi } from 'zustand/vanilla';
import type { AppContainer } from '../../../core/container/appContainer';
import { InvalidOtpException } from './authRepository';
import type { Auth } from './auth';

export interface AuthState {
  readonly auth: Auth;
  sendOtp(phone: string): Promise<void>;
  verifyOtp(code: string): Promise<void>;
  logout(): void;
}

export type AuthStore = StoreApi<AuthState>;

const initialAuth = (getContainer: () => AppContainer): Auth => {
  const session = getContainer().sessionRepository.restore();
  if (session === null) return { kind: 'unauthenticated' };
  return { kind: 'authenticated', userId: session.userId, phone: session.phone };
};

export const createAuthStore = (getContainer: () => AppContainer): AuthStore =>
  createStore<AuthState>((set, get) => ({
    auth: initialAuth(getContainer),
    sendOtp: async (phone) => {
      const current = get().auth;
      if (current.kind === 'sendingOtp' || current.kind === 'verifying') return;
      set({ auth: { kind: 'sendingOtp', phone } });
      try {
        await getContainer().authRepository.sendOtp(phone);
        set({ auth: { kind: 'otpSent', phone } });
      } catch {
        set({ auth: { kind: 'unauthenticated' } });
        getContainer().uiEvents.getState().emit({ kind: 'authFailed' });
      }
    },
    verifyOtp: async (code) => {
      const current = get().auth;
      if (current.kind !== 'otpSent') return;
      const { phone } = current;
      set({ auth: { kind: 'verifying', phone } });
      try {
        const userId = await getContainer().authRepository.verifyOtp(phone, code);
        set({ auth: { kind: 'authenticated', userId, phone } });
        await getContainer().sessionRepository.save(userId, phone);
      } catch (error) {
        set({ auth: { kind: 'otpSent', phone } });
        getContainer().uiEvents.getState().emit(
          error instanceof InvalidOtpException ? { kind: 'otpRejected' } : { kind: 'authFailed' },
        );
      }
    },
    logout: () => {
      void getContainer().sessionRepository.clear();
      set({ auth: { kind: 'unauthenticated' } });
    },
  }));

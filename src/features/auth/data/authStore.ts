import { createStore } from 'zustand/vanilla';
import { authFailed, otpRejected, type UiEventStore } from '@/core/event/uiEvents';
import type { AuthRepository } from './authRepository';
import { InvalidOtpError } from './authRepository';
import type { SessionRepository } from './sessionRepository';
import type { Auth } from './auth';

type Deps = { authRepository: AuthRepository; sessionRepository: SessionRepository; uiEvents: UiEventStore };

export type AuthState = {
  auth: Auth;
  sendOtp(phone: string): Promise<void>;
  verifyOtp(code: string): Promise<void>;
  logout(): void;
};

function initialAuth(deps: Deps): Auth {
  const session = deps.sessionRepository.restore();
  if (session === null) return { kind: 'unauthenticated' };
  return { kind: 'authenticated', userId: session.userId, phone: session.phone };
}

export const createAuthStore = (deps: Deps) =>
  createStore<AuthState>((set, get) => ({
    auth: initialAuth(deps),
    sendOtp: async (phone) => {
      const current = get().auth;
      if (current.kind === 'sendingOtp' || current.kind === 'verifying') return;
      set({ auth: { kind: 'sendingOtp', phone } });
      try {
        await deps.authRepository.sendOtp(phone);
        set({ auth: { kind: 'otpSent', phone } });
      } catch {
        set({ auth: { kind: 'unauthenticated' } });
        deps.uiEvents.getState().emit(authFailed());
      }
    },
    verifyOtp: async (code) => {
      const current = get().auth;
      if (current.kind !== 'otpSent') return;
      const phone = current.phone;
      set({ auth: { kind: 'verifying', phone } });
      try {
        const userId = await deps.authRepository.verifyOtp(phone, code);
        set({ auth: { kind: 'authenticated', userId, phone } });
        deps.sessionRepository.save(userId, phone);
      } catch (error) {
        set({ auth: { kind: 'otpSent', phone } });
        deps.uiEvents.getState().emit(error instanceof InvalidOtpError ? otpRejected() : authFailed());
      }
    },
    logout: () => {
      deps.sessionRepository.clear();
      set({ auth: { kind: 'unauthenticated' } });
    },
  }));

export type AuthStore = ReturnType<typeof createAuthStore>;

import { createAppContainer } from '@/core/container/appContainer';
import { InMemoryKeyValueStore } from '@/core/storage/keyValueStore';
import { MockNetwork } from '@/core/mock/mockNetwork';
import type { AuthRepository } from '@/features/auth/data/authRepository';

const fast = (over = {}) =>
  createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }), ...over });

describe('AuthStore', () => {
  it('sendOtp moves unauthenticated -> otpSent', async () => {
    const c = fast();
    await c.auth.getState().sendOtp('9876543210');
    expect(c.auth.getState().auth).toEqual({ kind: 'otpSent', phone: '9876543210' });
  });

  it('verifyOtp with six digits authenticates with user-$phone and saves session', async () => {
    const store = new InMemoryKeyValueStore();
    const c = fast({ keyValueStore: store });
    await c.auth.getState().sendOtp('9876543210');
    await c.auth.getState().verifyOtp('123456');
    expect(c.auth.getState().auth).toEqual({ kind: 'authenticated', userId: 'user-9876543210', phone: '9876543210' });
    expect(store.read('session.userId')).toBe('user-9876543210');
  });

  it('bad otp returns to otpSent and emits otpRejected', async () => {
    const c = fast();
    await c.auth.getState().sendOtp('9876543210');
    await c.auth.getState().verifyOtp('12');
    expect(c.auth.getState().auth).toEqual({ kind: 'otpSent', phone: '9876543210' });
    expect(c.uiEvents.getState().events).toEqual([{ kind: 'otpRejected' }]);
  });

  it('sendOtp re-entry while in flight is ignored', async () => {
    const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 5, maxDelayMs: 6 }) });
    const first = c.auth.getState().sendOtp('9876543210');
    const second = c.auth.getState().sendOtp('1111111111');
    await Promise.all([first, second]);
    expect(c.auth.getState().auth).toEqual({ kind: 'otpSent', phone: '9876543210' });
  });

  it('sendOtp network failure restores unauthenticated and emits authFailed', async () => {
    const exploding: AuthRepository = {
      sendOtp: async () => { throw new Error('down'); },
      verifyOtp: async () => 'user-x',
    };
    const c = fast({ authRepository: exploding });
    await c.auth.getState().sendOtp('9876543210');
    expect(c.auth.getState().auth).toEqual({ kind: 'unauthenticated' });
    expect(c.uiEvents.getState().events).toEqual([{ kind: 'authFailed' }]);
  });

  it('restores authenticated state from a session in a fresh container', async () => {
    const store = new InMemoryKeyValueStore();
    const c1 = fast({ keyValueStore: store });
    await c1.auth.getState().sendOtp('9876543210');
    await c1.auth.getState().verifyOtp('123456');
    const c2 = fast({ keyValueStore: store });
    expect(c2.auth.getState().auth.kind).toBe('authenticated');
  });

  it('logout resets to unauthenticated and clears the session on disk', async () => {
    const store = new InMemoryKeyValueStore();
    const c = fast({ keyValueStore: store });
    await c.auth.getState().sendOtp('9876543210');
    await c.auth.getState().verifyOtp('123456');
    c.auth.getState().logout();
    expect(c.auth.getState().auth).toEqual({ kind: 'unauthenticated' });
    expect(store.read('session.userId')).toBeNull();
  });
});

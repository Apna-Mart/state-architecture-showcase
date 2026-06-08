import { createAppContainer } from '@/core/container';
import { MockNetwork } from '@/core/mock/mockNetwork';

const instant = () => createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });

test('sendOtp transitions unauthenticated to otpSent', async () => {
  const c = instant();
  await c.auth.getState().sendOtp('9876543210');
  expect(c.auth.getState().auth).toEqual({ kind: 'otpSent', phone: '9876543210' });
});

test('verifyOtp with six digits authenticates with deterministic userId', async () => {
  const c = instant();
  await c.auth.getState().sendOtp('9876543210');
  await c.auth.getState().verifyOtp('123456');
  expect(c.auth.getState().auth).toEqual({ kind: 'authenticated', userId: 'user-9876543210', phone: '9876543210' });
});

test('verifyOtp with bad code returns to otpSent and emits otpRejected', async () => {
  const c = instant();
  await c.auth.getState().sendOtp('9876543210');
  await c.auth.getState().verifyOtp('12');
  expect(c.auth.getState().auth).toEqual({ kind: 'otpSent', phone: '9876543210' });
  expect(c.uiEvents.getState().events.map((e) => e.kind)).toEqual(['otpRejected']);
});

test('sendOtp re-entry while in flight is ignored', async () => {
  const c = instant();
  const first = c.auth.getState().sendOtp('9876543210');
  const second = c.auth.getState().sendOtp('1111111111');
  await Promise.all([first, second]);
  expect(c.auth.getState().auth).toEqual({ kind: 'otpSent', phone: '9876543210' });
});

test('logout resets to unauthenticated', async () => {
  const c = instant();
  await c.auth.getState().sendOtp('9876543210');
  await c.auth.getState().verifyOtp('123456');
  c.auth.getState().logout();
  expect(c.auth.getState().auth).toEqual({ kind: 'unauthenticated' });
});

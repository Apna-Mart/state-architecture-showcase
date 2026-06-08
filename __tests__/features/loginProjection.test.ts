import { projectLogin } from '@/features/auth/ui/loginProjection';

test('valid 10-digit phone enables send in phoneEntry', () => {
  const data = projectLogin({ kind: 'unauthenticated' }, '9876543210', '');
  expect(data).toEqual({ kind: 'phoneEntry', canSend: true, sending: false });
});

test('short or non-numeric phone disables send', () => {
  expect(projectLogin({ kind: 'unauthenticated' }, '12345', '').kind).toBe('phoneEntry');
  expect((projectLogin({ kind: 'unauthenticated' }, '12345', '') as { canSend: boolean }).canSend).toBe(false);
  expect((projectLogin({ kind: 'unauthenticated' }, 'abcdefghij', '') as { canSend: boolean }).canSend).toBe(false);
});

test('sendingOtp shows phoneEntry sending', () => {
  expect(projectLogin({ kind: 'sendingOtp', phone: '9876543210' }, '9876543210', '')).toEqual({ kind: 'phoneEntry', canSend: false, sending: true });
});

test('otpSent enables verify only for 6 digits', () => {
  expect(projectLogin({ kind: 'otpSent', phone: '9876543210' }, '', '123456')).toEqual({ kind: 'otpEntry', phone: '9876543210', canVerify: true, verifying: false });
  expect((projectLogin({ kind: 'otpSent', phone: '9876543210' }, '', '12') as { canVerify: boolean }).canVerify).toBe(false);
});

test('verifying shows otpEntry verifying', () => {
  expect(projectLogin({ kind: 'verifying', phone: '9876543210' }, '', '123456')).toEqual({ kind: 'otpEntry', phone: '9876543210', canVerify: false, verifying: true });
});

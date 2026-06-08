import { projectLogin } from '@/features/auth/ui/loginScreenData';

describe('projectLogin', () => {
  it('phone entry: send enabled only for 10 digits', () => {
    expect(projectLogin({ kind: 'unauthenticated' }, '', '')).toEqual({ kind: 'phoneEntry', canSend: false, sending: false });
    expect(projectLogin({ kind: 'unauthenticated' }, '9876543210', '')).toEqual({ kind: 'phoneEntry', canSend: true, sending: false });
    expect(projectLogin({ kind: 'unauthenticated' }, '98765', '')).toEqual({ kind: 'phoneEntry', canSend: false, sending: false });
  });
  it('sendingOtp shows phone entry sending', () => {
    expect(projectLogin({ kind: 'sendingOtp', phone: '9876543210' }, '9876543210', '')).toEqual({ kind: 'phoneEntry', canSend: false, sending: true });
  });
  it('otpSent shows otp entry; verify enabled at 6 digits', () => {
    expect(projectLogin({ kind: 'otpSent', phone: '9876543210' }, '9876543210', '12')).toEqual({ kind: 'otpEntry', phone: '9876543210', canVerify: false, verifying: false });
    expect(projectLogin({ kind: 'otpSent', phone: '9876543210' }, '9876543210', '123456')).toEqual({ kind: 'otpEntry', phone: '9876543210', canVerify: true, verifying: false });
  });
  it('verifying shows otp entry verifying', () => {
    expect(projectLogin({ kind: 'verifying', phone: '9876543210' }, '9876543210', '123456')).toEqual({ kind: 'otpEntry', phone: '9876543210', canVerify: false, verifying: true });
  });
});

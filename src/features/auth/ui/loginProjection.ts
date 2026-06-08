import { assertNever } from '@/core/async/async';
import type { Auth } from '../data/auth';
import type { LoginScreenData } from './loginScreenData';

const isValidPhone = (phone: string): boolean => phone.length === 10 && /^[0-9]+$/.test(phone);
const isValidOtp = (otp: string): boolean => otp.length === 6 && /^[0-9]+$/.test(otp);

export function projectLogin(auth: Auth, phoneInput: string, otpInput: string): LoginScreenData {
  switch (auth.kind) {
    case 'unauthenticated':
      return { kind: 'phoneEntry', canSend: isValidPhone(phoneInput), sending: false };
    case 'sendingOtp':
      return { kind: 'phoneEntry', canSend: false, sending: true };
    case 'otpSent':
      return { kind: 'otpEntry', phone: auth.phone, canVerify: isValidOtp(otpInput), verifying: false };
    case 'verifying':
      return { kind: 'otpEntry', phone: auth.phone, canVerify: false, verifying: true };
    case 'authenticated':
      return { kind: 'phoneEntry', canSend: false, sending: false };
    default:
      return assertNever(auth);
  }
}

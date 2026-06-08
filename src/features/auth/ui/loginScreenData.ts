import type { Auth } from '../data/auth';

export type LoginScreenData =
  | { readonly kind: 'phoneEntry'; readonly canSend: boolean; readonly sending: boolean }
  | { readonly kind: 'otpEntry'; readonly phone: string; readonly canVerify: boolean; readonly verifying: boolean };

export const projectLogin = (auth: Auth, phone: string, otp: string): LoginScreenData => {
  const validPhone = /^\d{10}$/.test(phone);
  switch (auth.kind) {
    case 'unauthenticated':
      return { kind: 'phoneEntry', canSend: validPhone, sending: false };
    case 'sendingOtp':
      return { kind: 'phoneEntry', canSend: false, sending: true };
    case 'otpSent':
      return { kind: 'otpEntry', phone: auth.phone, canVerify: otp.length === 6, verifying: false };
    case 'verifying':
      return { kind: 'otpEntry', phone: auth.phone, canVerify: false, verifying: true };
    case 'authenticated':
      return { kind: 'phoneEntry', canSend: false, sending: false };
  }
};

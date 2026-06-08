export type Auth =
  | { kind: 'unauthenticated' }
  | { kind: 'sendingOtp'; phone: string }
  | { kind: 'otpSent'; phone: string }
  | { kind: 'verifying'; phone: string }
  | { kind: 'authenticated'; userId: string; phone: string };

export const userIdOrNull = (auth: Auth): string | null =>
  auth.kind === 'authenticated' ? auth.userId : null;

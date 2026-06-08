export type Auth =
  | { readonly kind: 'unauthenticated' }
  | { readonly kind: 'sendingOtp'; readonly phone: string }
  | { readonly kind: 'otpSent'; readonly phone: string }
  | { readonly kind: 'verifying'; readonly phone: string }
  | { readonly kind: 'authenticated'; readonly userId: string; readonly phone: string };

export const userIdOrNull = (auth: Auth): string | null =>
  auth.kind === 'authenticated' ? auth.userId : null;

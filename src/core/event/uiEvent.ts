export type UiEvent =
  | { readonly kind: 'paymentStarted'; readonly paymentId: string }
  | { readonly kind: 'paymentFailed'; readonly paymentId: string }
  | { readonly kind: 'otpRejected' }
  | { readonly kind: 'authFailed' }
  | { readonly kind: 'storageFailed' };

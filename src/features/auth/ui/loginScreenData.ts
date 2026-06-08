export type LoginScreenData =
  | { kind: 'phoneEntry'; canSend: boolean; sending: boolean }
  | { kind: 'otpEntry'; phone: string; canVerify: boolean; verifying: boolean };

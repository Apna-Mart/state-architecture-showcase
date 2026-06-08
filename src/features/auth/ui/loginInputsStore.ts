import { createStore, type StoreApi } from 'zustand/vanilla';

export interface LoginInputsState {
  readonly phone: string;
  readonly otp: string;
  setPhone(phone: string): void;
  setOtp(otp: string): void;
}

export const createLoginInputsStore = (): StoreApi<LoginInputsState> =>
  createStore<LoginInputsState>((set) => ({
    phone: '',
    otp: '',
    setPhone: (phone) => set({ phone }),
    setOtp: (otp) => set({ otp }),
  }));

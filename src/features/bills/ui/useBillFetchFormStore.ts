import { useState } from 'react';
import { createStore } from 'zustand/vanilla';
import { emptyForm, settingValue, type BillFetchForm } from './billFetchForm';

type FormState = {
  form: BillFetchForm;
  editField(key: string, value: string): void;
  editAmount(value: string): void;
};

export function useBillFetchFormStore() {
  return useState(() =>
    createStore<FormState>((set, get) => ({
      form: emptyForm(),
      editField: (key, value) => set({ form: settingValue(get().form, key, value) }),
      editAmount: (value) => set({ form: { ...get().form, amountText: value } }),
    })),
  )[0];
}

export type BillFetchFormStore = ReturnType<typeof useBillFetchFormStore>;

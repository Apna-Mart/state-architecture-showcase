import { createStore, type StoreApi } from 'zustand/vanilla';
import { emptyForm, settingAmount, settingValue, type BillFetchForm } from './billFetchForm';

export interface BillFetchFormState {
  readonly form: BillFetchForm;
  editField(key: string, value: string): void;
  editAmount(value: string): void;
}

export const createBillFetchFormStore = (): StoreApi<BillFetchFormState> =>
  createStore<BillFetchFormState>((set, get) => ({
    form: emptyForm(),
    editField: (key, value) => set({ form: settingValue(get().form, key, value) }),
    editAmount: (value) => set({ form: settingAmount(get().form, value) }),
  }));

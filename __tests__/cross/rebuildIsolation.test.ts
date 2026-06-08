import { createAppContainer } from '@/core/container';
import { MockNetwork } from '@/core/mock/mockNetwork';
import { createStore } from 'zustand/vanilla';
import { emptyForm, settingValue, type BillFetchForm } from '@/features/bills/ui/billFetchForm';

test('editing a screen-local form store never notifies the payments or savedBillers stores', async () => {
  const c = createAppContainer({ network: new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }) });
  await c.auth.getState().sendOtp('9876543210');
  await c.auth.getState().verifyOtp('123456');

  let homeFacts = 0;
  const unsubPayments = c.payments.subscribe(() => (homeFacts += 1));
  const unsubSaved = c.savedBillers.subscribe(() => (homeFacts += 1));

  const formStore = createStore<{ form: BillFetchForm; edit(k: string, v: string): void }>((set, get) => ({
    form: emptyForm(),
    edit: (k, v) => set({ form: settingValue(get().form, k, v) }),
  }));
  formStore.getState().edit('account', 'K1');
  formStore.getState().edit('account', 'K12');

  expect(homeFacts).toBe(0);
  unsubPayments();
  unsubSaved();
});

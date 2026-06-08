export interface BillFetchForm {
  readonly values: Readonly<Record<string, string>>;
  readonly amountText: string;
}

export const emptyForm = (): BillFetchForm => ({ values: {}, amountText: '' });

export const valueOf = (form: BillFetchForm, key: string): string => form.values[key] ?? '';

export const settingValue = (form: BillFetchForm, key: string, value: string): BillFetchForm => ({
  ...form,
  values: { ...form.values, [key]: value },
});

export const settingAmount = (form: BillFetchForm, amountText: string): BillFetchForm => ({
  ...form,
  amountText,
});

export const amountPaise = (form: BillFetchForm): number | null => {
  const rupees = Number.parseFloat(form.amountText);
  if (!Number.isFinite(rupees) || rupees <= 0) return null;
  return Math.round(rupees * 100);
};

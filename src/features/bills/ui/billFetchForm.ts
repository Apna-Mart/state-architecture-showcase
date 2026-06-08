export type BillFetchForm = { values: Record<string, string>; amountText: string };

export const emptyForm = (): BillFetchForm => ({ values: {}, amountText: '' });

export const valueOf = (form: BillFetchForm, key: string): string => form.values[key] ?? '';

export const settingValue = (form: BillFetchForm, key: string, value: string): BillFetchForm => ({
  ...form,
  values: { ...form.values, [key]: value },
});

export const amountPaise = (form: BillFetchForm): number | null => {
  const rupees = Number(form.amountText);
  if (!Number.isFinite(rupees) || rupees <= 0 || form.amountText.trim() === '') return null;
  return Math.round(rupees * 100);
};

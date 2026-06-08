export type FetchFieldData = { key: string; label: string; hint: string };
export type FetchInputsData = { fields: FetchFieldData[]; showAmount: boolean };
export type FetchSubmitAction = 'fetchBill' | 'continueToReview';
export type FetchSubmitData = { action: FetchSubmitAction; location: string | null };
export type BillFetchScreenData =
  | { kind: 'loading' }
  | { kind: 'error'; message: string }
  | { kind: 'form'; billerName: string; inputs: FetchInputsData; submit: FetchSubmitData };

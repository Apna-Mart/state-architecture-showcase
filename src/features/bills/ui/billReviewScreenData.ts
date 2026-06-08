export type ReviewParams = { billerId: string; account: string; amountPaise: number | null };
export type BillReviewScreenData =
  | { kind: 'loading' }
  | { kind: 'error'; message: string }
  | {
      kind: 'review';
      billerId: string;
      categoryId: string;
      billerName: string;
      account: string;
      customerName: string | null;
      dueInDays: number | null;
      amountPaise: number;
      paying: boolean;
      canPay: boolean;
    };

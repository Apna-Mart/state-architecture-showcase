export type ReceiptScreenData =
  | { kind: 'notFound' }
  | { kind: 'processing'; billerName: string; amountPaise: number }
  | {
      kind: 'success';
      paymentId: string;
      billerId: string;
      billerName: string;
      account: string;
      amountPaise: number;
      paidAt: string;
      canSaveBiller: boolean;
    }
  | {
      kind: 'failed';
      billerId: string;
      billerName: string;
      categoryId: string;
      account: string;
      amountPaise: number;
    };

export interface FetchedBill {
  readonly billerId: string;
  readonly account: string;
  readonly customerName: string;
  readonly amountPaise: number;
  readonly dueDate: Date;
  readonly billNumber: string;
}

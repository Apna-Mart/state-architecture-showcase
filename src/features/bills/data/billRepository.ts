import type { Clock } from '../../../core/clock/clock';
import type { MockNetwork } from '../../../core/mock/mockNetwork';
import type { SavedBiller } from '../../saved_billers/data/savedBiller';
import type { FetchedBill } from './fetchedBill';

const CUSTOMERS = ['Ramesh Kumar', 'Priya Sharma', 'Amit Patel', 'Sunita Reddy', 'Vikram Singh'];

export interface BillRepository {
  fetchBill(billerId: string, account: string): Promise<FetchedBill>;
  fetchDueBills(saved: readonly SavedBiller[]): Promise<readonly FetchedBill[]>;
}

export class FakeBillRepository implements BillRepository {
  constructor(private readonly network: MockNetwork, private readonly clock: Clock) {}

  private static seedOf(billerId: string, account: string): number {
    const text = `${billerId}|${account}`;
    let sum = 0;
    for (let i = 0; i < text.length; i += 1) sum += text.charCodeAt(i);
    return sum;
  }

  private billFor(billerId: string, account: string): FetchedBill {
    const seed = FakeBillRepository.seedOf(billerId, account);
    const today = this.clock();
    const base = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    const dueDate = new Date(base.getTime() + ((seed % 15) - 3) * 86_400_000);
    return {
      billerId,
      account,
      customerName: CUSTOMERS[seed % CUSTOMERS.length]!,
      amountPaise: ((seed % 4500) + 200) * 100,
      dueDate,
      billNumber: `BILL-${seed.toString(16).toUpperCase()}-${seed}`,
    };
  }

  async fetchBill(billerId: string, account: string): Promise<FetchedBill> {
    await this.network.delay();
    return this.billFor(billerId, account);
  }

  async fetchDueBills(saved: readonly SavedBiller[]): Promise<readonly FetchedBill[]> {
    await this.network.delay(6);
    return saved.map((s) => this.billFor(s.billerId, s.account));
  }
}

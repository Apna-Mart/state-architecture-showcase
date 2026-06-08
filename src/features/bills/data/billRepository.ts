import { MockNetwork } from '@/core/mock/mockNetwork';
import type { Clock } from '@/core/clock/clock';
import type { SavedBiller } from '@/features/saved_billers/data/savedBiller';
import type { FetchedBill } from './fetchedBill';

const customers = ['Ramesh Kumar', 'Priya Sharma', 'Amit Patel', 'Sunita Reddy', 'Vikram Singh'];

const seedOf = (billerId: string, account: string): number =>
  [...`${billerId}|${account}`].reduce((sum, ch) => sum + ch.charCodeAt(0), 0);

export interface BillRepository {
  fetchBill(billerId: string, account: string): Promise<FetchedBill>;
  fetchDueBills(saved: SavedBiller[]): Promise<FetchedBill[]>;
}

export class FakeBillRepository implements BillRepository {
  constructor(private readonly network: MockNetwork, private readonly clock: Clock) {}

  private billFor(billerId: string, account: string): FetchedBill {
    const seed = seedOf(billerId, account);
    const today = this.clock();
    const dueDate = new Date(today.getFullYear(), today.getMonth(), today.getDate() + ((seed % 15) - 3));
    return {
      billerId,
      account,
      customerName: customers[seed % customers.length]!,
      amountPaise: ((seed % 4500) + 200) * 100,
      dueDate,
      billNumber: `BILL-${seed.toString(16).toUpperCase()}-${seed}`,
    };
  }

  async fetchBill(billerId: string, account: string): Promise<FetchedBill> {
    await this.network.delay();
    return this.billFor(billerId, account);
  }

  async fetchDueBills(saved: SavedBiller[]): Promise<FetchedBill[]> {
    await this.network.delay(6);
    return saved.map((s) => this.billFor(s.billerId, s.account));
  }
}

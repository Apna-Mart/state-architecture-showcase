import type { MockNetwork } from '../../../core/mock/mockNetwork';
import type { Payment } from './payment';

export interface PaymentRepository {
  pay(payment: Payment): Promise<void>;
}

export class FakePaymentRepository implements PaymentRepository {
  constructor(private readonly network: MockNetwork) {}

  async pay(_payment: Payment): Promise<void> {
    await this.network.delay();
    this.network.countAndMaybeFail();
  }
}

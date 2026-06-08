import type { MockNetwork } from '../../../core/mock/mockNetwork';

export class InvalidOtpException extends Error {
  constructor() {
    super('InvalidOtpException');
    this.name = 'InvalidOtpException';
  }
}

export interface AuthRepository {
  sendOtp(phone: string): Promise<void>;
  verifyOtp(phone: string, code: string): Promise<string>;
}

export class FakeAuthRepository implements AuthRepository {
  constructor(private readonly network: MockNetwork) {}

  async sendOtp(_phone: string): Promise<void> {
    await this.network.delay();
  }

  async verifyOtp(phone: string, code: string): Promise<string> {
    await this.network.delay();
    if (!/^\d{6}$/.test(code)) throw new InvalidOtpException();
    return `user-${phone}`;
  }
}

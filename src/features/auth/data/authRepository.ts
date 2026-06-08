import { MockNetwork } from '@/core/mock/mockNetwork';

export class InvalidOtpError extends Error {
  constructor() {
    super('InvalidOtpError');
    this.name = 'InvalidOtpError';
  }
}

export interface AuthRepository {
  sendOtp(phone: string): Promise<void>;
  verifyOtp(phone: string, code: string): Promise<string>;
}

export class FakeAuthRepository implements AuthRepository {
  constructor(private readonly network: MockNetwork) {}

  async sendOtp(): Promise<void> {
    await this.network.delay();
  }

  async verifyOtp(phone: string, code: string): Promise<string> {
    await this.network.delay();
    const isSixDigits = code.length === 6 && /^[0-9]+$/.test(code);
    if (!isSixDigits) throw new InvalidOtpError();
    return `user-${phone}`;
  }
}

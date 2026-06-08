import { FakeAuthRepository, InvalidOtpException } from '@/features/auth/data/authRepository';
import { MockNetwork } from '@/core/mock/mockNetwork';

const repo = () => new FakeAuthRepository(new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }));

describe('FakeAuthRepository', () => {
  it('verifyOtp returns user-$phone for six digits', async () => {
    await expect(repo().verifyOtp('9876543210', '123456')).resolves.toBe('user-9876543210');
  });
  it('verifyOtp throws InvalidOtpException for non-six-digit codes', async () => {
    await expect(repo().verifyOtp('9876543210', '12')).rejects.toBeInstanceOf(InvalidOtpException);
    await expect(repo().verifyOtp('9876543210', 'abcdef')).rejects.toBeInstanceOf(InvalidOtpException);
  });
  it('sendOtp resolves', async () => {
    await expect(repo().sendOtp('9876543210')).resolves.toBeUndefined();
  });
});

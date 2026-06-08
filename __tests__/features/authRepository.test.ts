import { MockNetwork } from '@/core/mock/mockNetwork';
import { FakeAuthRepository, InvalidOtpError } from '@/features/auth/data/authRepository';

const repo = () => new FakeAuthRepository(new MockNetwork({ minDelayMs: 0, maxDelayMs: 1 }));

test('verifyOtp with six digits returns user-$phone', async () => {
  expect(await repo().verifyOtp('9876543210', '123456')).toBe('user-9876543210');
});

test('verifyOtp rejects non-6-digit codes', async () => {
  await expect(repo().verifyOtp('9876543210', '12')).rejects.toThrow(InvalidOtpError);
  await expect(repo().verifyOtp('9876543210', 'abcdef')).rejects.toThrow(InvalidOtpError);
});

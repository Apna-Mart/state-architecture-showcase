import { emptyForm, valueOf, settingValue, amountPaise } from '@/features/bills/ui/billFetchForm';

describe('BillFetchForm', () => {
  it('settingValue is immutable and valueOf reads back', () => {
    const f = settingValue(emptyForm(), 'account', 'K123');
    expect(valueOf(f, 'account')).toBe('K123');
    expect(valueOf(emptyForm(), 'account')).toBe('');
  });
  it('amountPaise parses positive rupees to paise, null otherwise', () => {
    expect(amountPaise({ values: {}, amountText: '250' })).toBe(25000);
    expect(amountPaise({ values: {}, amountText: '0' })).toBeNull();
    expect(amountPaise({ values: {}, amountText: 'abc' })).toBeNull();
  });
});

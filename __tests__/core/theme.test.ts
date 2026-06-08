import { lightTheme, darkTheme, brandColors } from '@/core/theme/theme';

describe('theme', () => {
  it('light uses brandBlue primary, dark uses brandBlueLight', () => {
    expect(lightTheme.primary).toBe(brandColors.brandBlue);
    expect(darkTheme.primary).toBe(brandColors.brandBlueLight);
  });
  it('both use Rubik', () => {
    expect(lightTheme.fontFamily).toBe('Rubik');
    expect(darkTheme.fontFamily).toBe('Rubik');
  });
});

export const brand = {
  blue: '#11448A',
  blueLight: '#3161AD',
  yellow: '#FACC15',
  yellowSoft: '#FFCA49',
} as const;

export type AppPalette = {
  background: string;
  surface: string;
  text: string;
  textMuted: string;
  primary: string;
  onPrimary: string;
  secondary: string;
  error: string;
  border: string;
};

export const lightPalette: AppPalette = {
  background: '#FFFFFF',
  surface: '#F4F6FA',
  text: '#1A1C1E',
  textMuted: '#5A5F66',
  primary: brand.blue,
  onPrimary: '#FFFFFF',
  secondary: brand.yellow,
  error: '#B3261E',
  border: '#D7DCE4',
};

export const darkPalette: AppPalette = {
  background: '#101418',
  surface: '#1B2027',
  text: '#E6E8EC',
  textMuted: '#A2A8B2',
  primary: brand.blueLight,
  onPrimary: '#FFFFFF',
  secondary: brand.yellow,
  error: '#F2B8B5',
  border: '#2C333C',
};

export const fontFamily = 'Rubik';

export const radii = { card: 12, control: 8 } as const;
export const spacing = { xs: 4, sm: 8, md: 16, lg: 24, xl: 32 } as const;

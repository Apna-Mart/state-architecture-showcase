export const brandColors = {
  brandBlue: '#11448A',
  brandBlueLight: '#3161AD',
  brandYellow: '#FACC15',
  brandYellowSoft: '#FFCA49',
} as const;

export interface AppTheme {
  readonly mode: 'light' | 'dark';
  readonly primary: string;
  readonly onPrimary: string;
  readonly secondary: string;
  readonly background: string;
  readonly surface: string;
  readonly onSurface: string;
  readonly error: string;
  readonly border: string;
  readonly fontFamily: string;
}

export const lightTheme: AppTheme = {
  mode: 'light',
  primary: brandColors.brandBlue,
  onPrimary: '#FFFFFF',
  secondary: brandColors.brandYellow,
  background: '#FFFFFF',
  surface: '#F4F5F7',
  onSurface: '#11151C',
  error: '#BA1A1A',
  border: '#D4D7DD',
  fontFamily: 'Rubik',
};

export const darkTheme: AppTheme = {
  mode: 'dark',
  primary: brandColors.brandBlueLight,
  onPrimary: '#FFFFFF',
  secondary: brandColors.brandYellow,
  background: '#11151C',
  surface: '#1B202A',
  onSurface: '#E3E6EC',
  error: '#FFB4AB',
  border: '#3A404B',
  fontFamily: 'Rubik',
};

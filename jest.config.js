module.exports = {
  preset: '@react-native/jest-preset',
  setupFilesAfterEnv: ['@testing-library/react-native/matchers'],
  transformIgnorePatterns: [
    'node_modules/(?!(@react-native|react-native|@react-navigation|react-native-mmkv|react-native-nitro-modules|react-native-screens|react-native-safe-area-context|i18next-icu|intl-messageformat|@formatjs)/)',
  ],
  moduleNameMapper: {
    '^react-native-mmkv$': '<rootDir>/__mocks__/react-native-mmkv.ts',
    '^@/(.*)$': '<rootDir>/src/$1',
  },
};

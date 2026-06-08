import { AppRegistry } from 'react-native';
import React from 'react';
import { App } from './src/App';
import { name as appName } from './app.json';
import { MmkvKeyValueStore } from './src/core/storage/keyValueStore';
import { createMMKV } from 'react-native-mmkv';
import { createAppContainer } from './src/core/container/appContainer';
import { systemClock } from './src/core/clock/clock';

const container = createAppContainer({
  keyValueStore: new MmkvKeyValueStore(createMMKV()),
  clock: systemClock,
});
container.settings;
const RootComponent = () => React.createElement(App, { container });
AppRegistry.registerComponent(appName, () => RootComponent);

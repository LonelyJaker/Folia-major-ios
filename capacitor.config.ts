import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'top.izuna.foliamajor.ios',
  appName: 'Folia',
  webDir: 'dist',
  bundledWebRuntime: false,
  ios: {
    contentInset: 'never',
    allowsLinkPreview: false,
    scrollEnabled: false,
    backgroundColor: '#09090b',
    preferredContentMode: 'mobile',
  },
  server: {
    iosScheme: 'capacitor',
    allowNavigation: [
      '*.music.126.net',
      '*.163.com',
      '*.qq.com',
      '*.gtimg.cn',
      '*.kugou.com',
      '*'
    ]
  }
};

export default config;

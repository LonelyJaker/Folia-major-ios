// Folia iOS & Web 动态在线音源运行时配置
// 支持在 iOS Safari / PWA / Capacitor 环境下通过 localStorage 或 URL 参数动态配置在线音源 API 地址
(function () {
  window.__FOLIA_RUNTIME_CONFIG__ = window.__FOLIA_RUNTIME_CONFIG__ || {};
  try {
    var params = new URLSearchParams(window.location.search);
    var keys = [
      ['neteaseApiBase', 'folia_ios_netease_api_base', 'neteaseApi'],
      ['qqApiBase', 'folia_ios_qq_api_base', 'qqApi'],
      ['kugouApiBase', 'folia_ios_kugou_api_base', 'kugouApi'],
      ['lyricProxyBase', 'folia_ios_lyric_proxy_base', 'lyricProxy']
    ];
    for (var i = 0; i < keys.length; i++) {
      var cfgKey = keys[i][0];
      var lsKey = keys[i][1];
      var urlParam = keys[i][2];
      var fromUrl = params.get(urlParam);
      if (fromUrl) {
        localStorage.setItem(lsKey, fromUrl.replace(/\/$/, ''));
      }
      var stored = localStorage.getItem(lsKey);
      if (stored && !window.__FOLIA_RUNTIME_CONFIG__[cfgKey]) {
        window.__FOLIA_RUNTIME_CONFIG__[cfgKey] = stored.replace(/\/$/, '');
      }
    }
  } catch (e) {
    // Ignore storage access errors in restricted frames
  }
})();

# Folia iOS 在线音源版使用与部署指南

本工程包已针对 **iOS 在线音源** 进行了专门改造，解决了原版 Web/移动端构建中在线音源地址必须编译期写死、iOS 灵动岛/安全区遮挡以及后台音频播放配置缺失的问题。

## 一、核心改动一览

1. **支持运行时动态配置在线音源 API 地址**：
   - 已改造 `src/services/onlineMusic/netease/netease.ts`、`src/services/onlineMusic/qq/qqTransport.ts`、`src/services/onlineMusic/kugou/kugouTransport.ts` 与 `src/services/lyricProxy.ts`。
   - 无需重新编译，在 iOS Safari / PWA 或 Capacitor App 中可通过 URL 参数一次性注入并持久化到 `localStorage`：
     `https://你的部署域名/?neteaseApi=https://你的网易云API&qqApi=/api/qq&kugouApi=https://你的酷狗API`
   - 也可直接在浏览器控制台或配置面板写入 `localStorage`:
     - `folia_ios_netease_api_base`：NeteaseCloudMusicApiEnhanced 服务地址
     - `folia_ios_qq_api_base`：QQ 音乐 API 地址（Vercel/Cloudflare 同源填 `/api/qq`）
     - `folia_ios_kugou_api_base`：KuGouMusicApi 服务地址
     - `folia_ios_lyric_proxy_base`：歌词代理地址（Capacitor 独立打包时指向你的 Web 部署域名）
   - **Navidrome 私有云**：直接在应用内「设置 → 连接与集成 → Navidrome」填入服务器 URL、用户名与密码即可连接。

2. **iOS 视图与安全区适配**：
   - `index.html` 已开启 `viewport-fit=cover` 与 iOS Standalone PWA 沉浸式状态栏（`black-translucent`），适配灵动岛与底部 Home 指示条。

3. **内置 Capacitor iOS 配置与免 Mac 云端打包 `.ipa` 工作流**：
   - 根目录已包含 `capacitor.config.ts`。
   - `.github/workflows/ios-ipa-build.yml` 提供一键 GitHub Actions 云编译：推送到你的 GitHub 仓库后，在 **Actions → Build iOS IPA (Online Sources Edition) → Run workflow** 即可生成 `Folia-iOS-Unsigned.ipa`（自动注入 `UIBackgroundModes: audio` 锁屏后台播放权限与 HTTP 音源访问权限），可通过 **TrollStore（巨魔）**、**AltStore**、**SideStore** 或 **Sideloadly** 安装至 iPhone / iPad。

## 二、三种 iOS 使用方式

### 方式 1：直接使用单文件 `folia-ios.html`（最快、零部署）
- 将随附的 `folia-ios.html` 发送到 iPhone/iPad（通过隔空投送 AirDrop、微信文件传输助手或存储在「文件」App / iCloud Drive），使用 Safari 打开并「添加到主屏幕」。
- 内置 **Apple Music/iTunes 在线直连流 + LRCLib 自动同步歌词**（免配置即搜即播），同时支持在右上角「音源配置」中一键填入你的 **网易云 API**、**QQ 音乐 API**、**酷狗 API** 或 **Navidrome** 账号。

### 方式 2：Vercel / Cloudflare 一键部署 iOS PWA（推荐日常在线听歌）
1. 将本仓库上传至 GitHub 并导入 Vercel。
2. 在 Vercel 环境变量中配置：
   - `VITE_NETEASE_API_BASE` = 你的 `NeteaseCloudMusicApiEnhanced` 地址
   - `VITE_QQ_API_BASE` = `/api/qq`
   - `QQ_SESSION_SECRET` = 任意 32 位随机字符串（用于内置 Serverless QQ 音乐扫码登录）
3. 部署完成后，用 iOS Safari 打开生成的网址，点击底部「分享 → 添加到主屏幕」，即可获得全屏无地址栏的原生级 iOS 应用体验。

### 方式 3：通过 GitHub Actions 生成 `.ipa` 侧载安装
1. 将本工程推送到 GitHub 私库或公库。
2. 打开仓库的 **Actions** 页面，选择 **Build iOS IPA (Online Sources Edition)**，点击 **Run workflow** 并填入你的在线音源 API 地址。
3. 等待约 4 分钟编译完成，下载 `Folia-iOS-Unsigned-IPA` 产物，使用 TrollStore 或签名工具（Sideloadly / AltStore）安装到 iOS 设备。

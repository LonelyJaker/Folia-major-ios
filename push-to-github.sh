#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
if [ ! -d ".git" ]; then
  git init -b main
  git add -A
  git commit -m "feat(ios): add iOS online sources runtime support, Capacitor config, and IPA build workflow"
fi
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/LonelyJaker/Folia-major-ios.git
git branch -M main
echo "正在推送到 https://github.com/LonelyJaker/Folia-major-ios.git ..."
git push -u origin main --force
echo "推送成功！请打开 https://github.com/LonelyJaker/Folia-major-ios/actions 查看并下载生成的 Folia-iOS-Unsigned.ipa"

@echo off
if "%~1"=="" (
    cmd /k "%~f0" RUN
    exit /b
)
chcp 65001 >nul 2>nul
cd /d "%~dp0"
echo ============================================================
echo   Folia iOS - GitHub Auto Push Tool
echo   Target: https://github.com/LonelyJaker/Folia-major-ios.git
echo ============================================================
echo.
where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git was not found in your system PATH.
    echo Please install Git for Windows from https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)
echo [1/4] Configuring Git safe directory & repository...
git config --global --add safe.directory "*" >nul 2>nul
if exist ".git" (
    rmdir /s /q ".git" >nul 2>nul
)
git init -b main
git config user.name "LonelyJaker"
git config user.email "LonelyJaker@users.noreply.github.com"
git config core.autocrlf false
echo.
echo [2/4] Staging all Folia iOS files (this may take 10-20 seconds)...
git add -A
echo.
echo [3/4] Creating commit...
git commit -m "feat(ios): add iOS online sources runtime support, Capacitor config, and IPA build workflow"
git branch -M main
git remote remove origin >nul 2>nul
git remote add origin https://github.com/LonelyJaker/Folia-major-ios.git
echo.
echo [4/4] Pushing to https://github.com/LonelyJaker/Folia-major-ios.git ...
echo (If a GitHub sign-in window or token prompt appears, please complete sign-in)
git push -u origin main --force
if errorlevel 1 (
    echo.
    echo [!] Push failed. Common reasons:
    echo     1. The repository https://github.com/LonelyJaker/Folia-major-ios does not exist yet.
    echo        -> Please create an empty repo named Folia-major-ios on GitHub first.
    echo     2. GitHub authentication was cancelled or timed out.
    echo        -> Run this script again and sign in when prompted.
) else (
    echo.
    echo [SUCCESS] Code pushed successfully!
    echo Open https://github.com/LonelyJaker/Folia-major-ios/actions to download Folia-iOS-Unsigned.ipa
)
echo.
pause

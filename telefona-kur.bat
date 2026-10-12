@echo off
chcp 65001 >nul
title Gunum telefona kur
echo.
echo  Gunum telefona kuruluyor...
echo  (Telefon USB ile bagli ve "USB hata ayiklama" acik olmali.)
echo.
set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "ADB=%ANDROID_HOME%\platform-tools\adb.exe"

"%ADB%" get-state >nul 2>&1
if errorlevel 1 (
    echo  [!] Bagli telefon bulunamadi.
    echo      - USB kablosunu kontrol et
    echo      - Telefonda "USB hata ayiklama" acik mi?
    echo      - Telefonda cikan "Bu bilgisayara izin ver" sorusunu onayla
    echo.
    pause
    exit /b 1
)

echo  1/2  Son degisiklikler Android projesine aktariliyor...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0aktar.ps1"
if errorlevel 1 ( echo  [!] Aktarma basarisiz. & pause & exit /b 1 )

echo.
echo  2/2  Uygulama derlenip telefona kuruluyor (ilk seferde birkac dakika surebilir)...
cd /d "%~dp0android"
call gradlew.bat installDebug --console=plain -q
if errorlevel 1 ( echo  [!] Kurulum basarisiz. Yukaridaki hatayi Claude'a goster. & pause & exit /b 1 )

"%ADB%" shell monkey -p com.peri.gunum -c android.intent.category.LAUNCHER 1 >nul 2>&1
echo.
echo  Tamam: Gunum telefonunda acildi.
echo.
pause

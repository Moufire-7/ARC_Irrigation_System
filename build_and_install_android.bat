@echo off
REM Android Build and Install - Workaround for Gradle Cache Issues
echo.
echo ================================================
echo   AquaLink - Build APK and Install on Android
echo ================================================
echo.
echo This builds an APK file and installs it directly
echo Workaround for Gradle daemon cache issues
echo.

cd /d "%~dp0"

echo Step 1: Stopping all Gradle processes...
cd android
call gradlew --stop 2>nul
cd ..

echo.
echo Step 2: Killing Java processes...
taskkill /F /IM java.exe /T >nul 2>&1
taskkill /F /IM javaw.exe /T >nul 2>&1
timeout /t 3 /nobreak >nul

echo.
echo Step 3: Cleaning Flutter cache...
call flutter clean

echo.
echo Step 4: Getting dependencies...
call flutter pub get

echo.
echo Step 5: Building APK (this takes 5-10 minutes)...
echo Please be patient...
call flutter build apk --debug

echo.
if exist "build\app\outputs\flutter-apk\app-debug.apk" (
    echo ================================================
    echo   BUILD SUCCESSFUL!
    echo ================================================
    echo.
    echo Step 6: Installing on your phone...
    echo Make sure your phone is connected!
    echo.
    
    REM Try to install using flutter
    call flutter install
    
    if errorlevel 1 (
        echo.
        echo Installation via Flutter failed, trying ADB...
        REM Fallback to ADB
        cd android
        call gradlew installDebug
        cd ..
    )
    
    echo.
    echo ================================================
    echo   DONE! App should be on your phone
    echo ================================================
    echo.
    echo You can now manually launch the app:
    echo  - Look for "Aqua Link Grow Smart" on your phone
    echo.
) else (
    echo.
    echo ================================================
    echo   BUILD FAILED
    echo ================================================
    echo.
    echo Try running the commands manually - see FIX_ANDROID_BUILD.md
    echo.
)

pause


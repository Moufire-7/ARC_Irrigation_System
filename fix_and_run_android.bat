@echo off
REM Complete Android Build Fix and Run Script
echo.
echo ================================================
echo   AquaLink - Android Build Fix
echo ================================================
echo.
echo This will:
echo 1. Stop all Gradle/Java processes
echo 2. Clean all build caches
echo 3. Rebuild and run on Android
echo.
echo This may take 5-10 minutes...
echo.

cd /d "%~dp0"

echo Step 1: Stopping Gradle daemons...
cd android
call gradlew --stop
cd ..

echo.
echo Step 2: Killing any remaining Java processes...
taskkill /F /IM java.exe /T >nul 2>&1
taskkill /F /IM javaw.exe /T >nul 2>&1

echo.
echo Step 3: Cleaning Flutter build cache...
flutter clean

echo.
echo Step 4: Removing Gradle cache...
if exist "%USERPROFILE%\.gradle\caches" (
    echo Removing Gradle caches...
    rmdir /S /Q "%USERPROFILE%\.gradle\caches" >nul 2>&1
)
if exist "%USERPROFILE%\.gradle\daemon" (
    echo Removing Gradle daemons...
    rmdir /S /Q "%USERPROFILE%\.gradle\daemon" >nul 2>&1
)

echo.
echo Step 5: Removing Android build folder...
if exist "android\build" (
    rmdir /S /Q "android\build"
)
if exist "android\app\build" (
    rmdir /S /Q "android\app\build"
)

echo.
echo Step 6: Getting Flutter dependencies...
flutter pub get

echo.
echo Step 7: Building and running on Android...
echo This will take several minutes on first build...
echo.
flutter run -d android

pause


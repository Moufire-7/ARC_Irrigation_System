@echo off
REM Quick PATH Refresh Script
REM Run this if "flutter" command is not recognized

echo.
echo ================================================
echo   Refreshing PATH for Flutter...
echo ================================================
echo.

PowerShell -ExecutionPolicy Bypass -File "%~dp0refresh_path.ps1"

pause


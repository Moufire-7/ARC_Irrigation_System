# Refresh PATH and Ensure PowerShell Profile is Set Up
# Run this if "flutter" command is not recognized

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "   Flutter PATH Setup & Verification" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Check if PowerShell Profile exists and has Flutter PATH
Write-Host "Checking PowerShell Profile..." -ForegroundColor Yellow

if (!(Test-Path $PROFILE)) {
    Write-Host "Creating PowerShell Profile..." -ForegroundColor Yellow
    New-Item -Path $PROFILE -ItemType File -Force | Out-Null
}

$profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue

if ($profileContent -notlike "*Flutter*") {
    Write-Host "Adding Flutter to PowerShell Profile..." -ForegroundColor Yellow
    Add-Content -Path $PROFILE -Value "`n# Auto-add Flutter to PATH`n`$env:Path += ';C:\Users\Sange\Flutter\bin'"
    Write-Host "✓ Flutter added to PowerShell Profile!" -ForegroundColor Green
} else {
    Write-Host "✓ Flutter already in PowerShell Profile" -ForegroundColor Green
}

Write-Host ""
Write-Host "Refreshing PATH in current session..." -ForegroundColor Yellow
$env:Path += ';C:\Users\Sange\Flutter\bin'

Write-Host "✓ PATH refreshed!" -ForegroundColor Green
Write-Host ""
Write-Host "Testing Flutter command..." -ForegroundColor Yellow

# Test if flutter is now available
try {
    $flutterVersion = & flutter --version 2>&1 | Select-Object -First 1
    Write-Host "✓ Flutter is working!" -ForegroundColor Green
    Write-Host "$flutterVersion" -ForegroundColor White
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host "  SUCCESS! Flutter will now work in all" -ForegroundColor Green
    Write-Host "  future PowerShell sessions automatically!" -ForegroundColor Green  
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "You can now use 'flutter run' commands! 🚀" -ForegroundColor Cyan
} catch {
    Write-Host "✗ Flutter command not found." -ForegroundColor Red
    Write-Host "Make sure Flutter is installed at: C:\Users\Sange\Flutter" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan


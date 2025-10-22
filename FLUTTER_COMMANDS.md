# 🚀 Flutter Commands Quick Reference

Flutter has been added to your PATH! You can now use simple `flutter` commands.

## 📌 PATH Setup Complete!

Flutter has been added to your PATH! If you open a new PowerShell window and `flutter` is not recognized:

**Quick Fix**: Double-click **`refresh_path.bat`** or run:
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

---

## 🎯 Most Common Commands

### Run the App
```bash
# Navigate to project first
cd "C:\Users\Sange\New Aqualink\aqua-link-grow-smart"

# Run on Windows (fastest for testing)
flutter run -d windows

# Run on Android phone
flutter run -d android

# Run on Chrome
flutter run -d chrome

# Run on default device
flutter run
```

### Build for Production
```bash
# Android APK
flutter build apk

# Android App Bundle (for Play Store)
flutter build appbundle

# Web
flutter build web
```

### Other Useful Commands
```bash
# See all connected devices
flutter devices

# Check Flutter installation
flutter doctor

# Get dependencies
flutter pub get

# Clean build cache
flutter clean

# Upgrade Flutter
flutter upgrade

# Check Flutter version
flutter --version
```

---

## 🔥 Hot Reload & Restart

When your app is running:
- **`r`** - Hot reload (updates UI instantly)
- **`R`** - Hot restart (full app restart)
- **`q`** - Quit the app
- **`h`** - Help (show all commands)
- **`d`** - Detach (app keeps running)
- **`c`** - Clear screen

---

## 💡 Pro Tips

1. **Always navigate to project folder first!**
   ```bash
   cd "C:\Users\Sange\New Aqualink\aqua-link-grow-smart"
   ```

2. **Use Windows for fast testing** - No phone setup needed!
   ```bash
   flutter run -d windows
   ```

3. **Hot reload is your friend** - Press `r` to see changes instantly without restarting

4. **Clean when stuck** - If builds fail mysteriously:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

5. **Use the batch files** - Double-click `run_app_windows.bat` for instant launch!

---

## ✅ PATH Setup Complete!

✅ Flutter added to system PATH  
✅ All documentation updated  
✅ Batch files simplified  
✅ Ready to use simple `flutter` commands  

**Next step**: Close and reopen your terminal, then try:
```bash
flutter --version
```

If you see the Flutter version, you're all set! 🎉


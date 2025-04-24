# doctor: verify setup
flutter doctor

# fetch packages
flutter pub get

# list devices/emulators
flutter devices

# launch emulator (choose from flutter emulators)
flutter emulators --launch pixel_4_api_30

# run in debug on your phone or emulator
flutter run -d <device_id>

# run in web (Chrome)
flutter run -d chrome

# hot-reload (after flutter run): press `r` in terminal
# hot-restart: press `R`

# build release
flutter build apk --release
flutter build ios --release

# static analysis
flutter analyze

# run tests
flutter test

# clean build artifacts
flutter clean

# For ios

sudo gem install -n /usr/local/bin cocoapods -v 1.8.4
sudo gem install -n /usr/local/bin cocoapods -v 1.10.0

# to update dependencies (in ios folder)
pod install --repo-update 

flutter run -d chrome --web-hostname localhost --web-port 5000


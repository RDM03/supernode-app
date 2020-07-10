# Supernode App

Github ![Build APK](https://github.com/mxc-foundation/supernode-app/workflows/Build%20APK/badge.svg)

AppCenter [![Build status](https://build.appcenter.ms/v0.1/apps/8db186c7-c9e6-4fcd-9ebf-0e7a3b536dcc/branches/master/badge)](https://appcenter.ms)


Mobile app used to interact with MXC Supernodes.

# Environment setup
- Follow [flutter get-started](https://flutter.dev/docs/get-started/install) to setup flutter and Android Studio
- Add this project to Android Studio

# When building locally (eg. not in appcenter)
- update the variables in .env file and execute it to add them to your env variables
```
/bin/bash .env
```

- follow the steps from appcenter build script android/app/appcenter-post-clone.sh
```
flutter clean
flutter build apk --flavor prod
``

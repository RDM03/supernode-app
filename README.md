# Supernode App

Github ![CI](https://github.com/mxc-foundation/supernode-app/workflows/CI/badge.svg)

AppCenter [![CI/CD](https://build.appcenter.ms/v0.1/apps/8db186c7-c9e6-4fcd-9ebf-0e7a3b536dcc/branches/master/badge)](https://appcenter.ms)


Mobile app used to interact with MXC Supernodes.

# Project Beginning

## Using Visual Studio Code

You can install `fish-redux-template` of the extension in the Visual Studio code, which it is very convenient to create relative code files.

Select a fold and right click and then it will display some menus: `Generate Adapter Template`,`Generate Component Template`,`Generate Page Template`.

## WeChat plugin

DataDash app uses a local fork of WeChat flutter plugin i.e. fluwx, as a git submodule in [supernode-app ROOT]/packages folder.

The fork is in mxc-foundation repository:
https://github.com/mxc-foundation/fluwx

### Working with fluwx submodule

In folder [supernode-app ROOT]/packages execute:

git clone https://github.com/mxc-foundation/fluwx
git submodule init
git submodule update

## Running in the Android Simulator

Now right it temporary only use the command `flutter run --flavor prod` or `flutter run --flavor play` to run in the Android Simulator.

The `prod` and `play` represent the name of channel distribution. The `prod` is the common channels for Android. And `play` shows it is only for google play.

# Environment setup
- Follow [flutter get-started](https://flutter.dev/docs/get-started/install) to setup flutter and Android Studio
- Add this project to Android Studio
- Create assets/.env file with following content:
```
JIRA_AUTH=${JIRA_AUTH}
JIRA_PROJECT_KEY=${JIRA_PROJECT_KEY}
MAP_BOX_ACCESS_TOKEN=${MAP_BOX_ACCESS_TOKEN}
APPCENTER_SECRET_ANDROID=${APPCENTER_SECRET_ANDROID}
APPCENTER_SECRET_IOS=${APPCENTER_SECRET_IOS}
APPCENTER_TOKEN_ANDROID=${APPCENTER_TOKEN_ANDROID}
APPCENTER_TOKEN_IOS=${APPCENTER_TOKEN_IOS}
APPCENTER_APPID_IOS=${APPCENTER_APPID_IOS}
```
JIRA_AUTH is 'email:token' encoded in base64

# When building locally (eg. not in appcenter)
- update the variables in .env file and execute it to add them to your env variables
```
/bin/bash .env
```

- follow the steps from appcenter build script android/app/appcenter-post-clone.sh
```
flutter clean
flutter build apk --flavor prod
```

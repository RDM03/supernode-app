#!/usr/bin/env bash
#Place this script in project/android/app/

cd ..

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b beta https://github.com/flutter/flutter.git
cd flutter
git reset --hard 2.1.0-12.2.pre
cd ..
export PATH=`pwd`/flutter/bin:$PATH

flutter clean

# accepting all licenses
yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

#flutter channel stable
#flutter doctor -v --android-licenses

echo "Installed flutter to `pwd`/flutter"

touch assets/.env
echo "JIRA_AUTH=${JIRA_AUTH}" > assets/.env
echo "JIRA_PROJECT_KEY=${JIRA_PROJECT_KEY}" >> assets/.env
echo "MAP_BOX_ACCESS_TOKEN=${MAP_BOX_ACCESS_TOKEN}" >> assets/.env
echo "MAP_BOX_SECRET_KEY=${MAP_BOX_SECRET_KEY}" >> assets/.env
echo "SDK_REGISTRY_TOKEN=${MAP_BOX_SECRET_KEY}" >> assets/.env
echo "APPCENTER_SECRET_ANDROID=${APPCENTER_SECRET_ANDROID}" >> assets/.env
echo "APPCENTER_SECRET_IOS=${APPCENTER_SECRET_IOS}" >> assets/.env
echo "APPCENTER_TOKEN_ANDROID=${APPCENTER_TOKEN_ANDROID}" >> assets/.env
echo "APPCENTER_TOKEN_IOS=${APPCENTER_TOKEN_IOS}" >> assets/.env
echo "APPCENTER_APPID_IOS=${APPCENTER_APPID_IOS}" >> assets/.env
echo "APPCENTER_KEYSTORE_PASSWORD=${APPCENTER_KEYSTORE_PASSWORD}" >> assets/.env
echo "APPCENTER_KEY_ALIAS=${APPCENTER_KEY_ALIAS}" >> assets/.env
echo "APPCENTER_KEY_PASSWORD=${APPCENTER_KEY_PASSWORD}" >> assets/.env
export SDK_REGISTRY_TOKEN=${MAP_BOX_SECRET_KEY}

# build APK
flutter build apk --flavor prod

# if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
flutter build appbundle --flavor play

# copy the APK where AppCenter will find it
mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/apk/prod/release/app-prod-release.apk $_

# copy the AAB where AppCenter will find it
mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/playRelease/app-play-release.aab $_

#!/usr/bin/env bash
#Place this script in project/ios/

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

echo "Installed flutter to `pwd`/flutter"

touch assets/.env
echo "JIRA_AUTH=${JIRA_AUTH}" > assets/.env
echo "JIRA_PROJECT_KEY=${JIRA_PROJECT_KEY}" >> assets/.env
echo "MAP_BOX_ACCESS_TOKEN=${MAP_BOX_ACCESS_TOKEN}" >> assets/.env
echo "APPCENTER_SECRET_ANDROID=${APPCENTER_SECRET_ANDROID}" >> assets/.env
echo "APPCENTER_SECRET_IOS=${APPCENTER_SECRET_IOS}" >> assets/.env
echo "APPCENTER_TOKEN_ANDROID=${APPCENTER_TOKEN_ANDROID}" >> assets/.env
echo "APPCENTER_TOKEN_IOS=${APPCENTER_TOKEN_IOS}" >> assets/.env
echo "APPCENTER_APPID_IOS=${APPCENTER_APPID_IOS}" >> assets/.env

if [ ! -z "$GOOGLE_SERVICES_PLIST" ]; then
  echo $GOOGLE_SERVICES_PLIST | base64 --decode > "$APPCENTER_SOURCE_DIRECTORY/ios/Runner/GoogleService-Info.plist"
fi

head "$APPCENTER_SOURCE_DIRECTORY/ios/Runner/GoogleService-Info.plist"

cat > ~/.netrc <<- EOM
machine api.mapbox.com
   login mapbox
   password ${MAP_BOX_SECRET_KEY}
EOM

flutter build ios --release --no-codesign

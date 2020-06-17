#!/usr/bin/env bash
#Place this script in project/ios/

# fail if any command fails
set -e
# debug log
set -x

echo "print current folder"
pwd
ls -l

echo "fix for https://github.com/flutter/flutter/issues/14161"
rm -rf ios/Flutter/Flutter.framework
pod install

echo "doing normal stuff"
cd ..
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter channel stable
flutter doctor

echo "Installed flutter to `pwd`/flutter"

flutter build ios --release --no-codesign

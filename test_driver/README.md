# Running Flutter Driver

This only works on flutter channel beta, I can't seem to get it to work properly on the latest stable version. 

Use the following ENV variables for your credentials:
* ENVIRONMENT=test
* TESTING_USER
* TESTING_PASSWORD
* MINER_SERIAL
* MXCTEST_OTP_KEY

OPTIONAL: (ENVIRONMENT var not needed with all this)

* ENLINK_PASSWORD
* XY_PASSWORD
* HUAWEITECH_PASSWORD
* MATCHXEU_PASSWORD
* SEJONG_PASSWORD
* MXCBUILD_PASSWORD
* MXCCHINA_PASSWORD

Currently, to change server you're testing you must change the value in the loginPageTests() function in app_test.dart. All test accounts use the same email in this version.

Then run: `flutter drive --target=test_driver/app.dart`

If you already have the app installed, you can try `flutter drive --target=test_driver/app.dart --no-build`

### To Note

Flutter Driver is unable to interact with native iOS/Android elements, that means we cannot approve location services. This will cause the login test to fail. For Android there [is a workaround](https://github.com/flutter/flutter/issues/12561).

Here is a [potential iOS workaround](https://github.com/flutter/flutter/issues/12561#issuecomment-589996014).

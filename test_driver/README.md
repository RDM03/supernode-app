# Running Flutter Driver

This only works on flutter channel beta, I can't seem to get it to work properly on the latest stable version. 

Use the following ENV variables for your credentials:
* TESTING_USER
* TESTING_PASSWORD
* OTP_KEY

Then on iOS run: `flutter drive --target=test_driver/app.dart`
For android: `flutter drive --target=test_.dart --no-build --flavor prod`

If you already have the app installed, you can try `flutter drive --target=test_driver/app.dart --no-build`

### To Note

Flutter Driver is unable to interact with native iOS/Android elements, that means we cannot approve location services. This will cause the login test to fail. For Android there [is a workaround](https://github.com/flutter/flutter/issues/12561).

Here is a [potential iOS workaround](https://github.com/flutter/flutter/issues/12561#issuecomment-589996014).
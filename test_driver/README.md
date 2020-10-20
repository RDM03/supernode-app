# Running Flutter Driver

Currently this only works on flutter channel beta, I can't seem to get it to work properly on the latest stable version. 

Environment variables are also not working at the moment.

Replace the password string in `app_test.dart` with the correct login password before running. 

Then run: `flutter drive --target=test_driver/app.dart
`
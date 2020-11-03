import 'package:flutter_driver/flutter_driver.dart';

Future<void> delay([int milliseconds = 250]) async {
  await Future<void>.delayed(Duration(milliseconds: milliseconds));
}

isPresent(SerializableFinder byValueKey, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 20)}) async {
  try {
    await driver.waitFor(byValueKey, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}

canTap(SerializableFinder byValueKey, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 2)}) async {
  try {
    await driver.tap(byValueKey, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}

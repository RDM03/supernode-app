import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'utils.dart' show isPresent;

logoutTest() {
  final settingsButtonDashboard = find.byValueKey('settingsButton');
  final logoutFinder = find.byValueKey('logout');
  final logoFinder = find.byValueKey('homeLogo');

  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('can logout', () async {
    await driver.tap(settingsButtonDashboard);
    await driver.scrollIntoView(logoutFinder);
    await driver.tap(logoutFinder);
    await driver.waitFor(logoFinder);
    final logoIsPresent = await isPresent(logoFinder, driver);
    expect(logoIsPresent, true);
  });
}

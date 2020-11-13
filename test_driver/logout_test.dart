import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show isPresent;

logoutTest(String server) {
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
    await driver.tap(f['settingsButtonDashboard']);
    await driver.scrollIntoView(f['logoutFinder']);
    await driver.tap(f['logoutFinder']);
    await driver.waitFor(f['logoFinder']);
    final logoIsPresent = await isPresent(f['logoFinder'], driver);
    expect(logoIsPresent, true);
    print('COMPLETED ' + server + ' TESTING');
  });
}

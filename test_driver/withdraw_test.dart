import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'utils.dart' show delay, canTap, isPresent;

withdrawTest() {
  final withdrawButtonDashboard = find.byValueKey('withdrawButtonDashboard');
  final helpTextFinder = find.byValueKey('helpText');
  final questionCircle = find.byValueKey('questionCircle');
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

  test('can withdraw', () async {
    print('NAVIGATE TO WITHDRAW');
    await driver.waitFor(withdrawButtonDashboard);
    await driver.tap(withdrawButtonDashboard);
    print('CHECKING ? BUTTON');
    await driver.waitFor(questionCircle);
    await driver.tap(questionCircle);
    delay(5000);
    var isExists = await isPresent(helpTextFinder, driver);
    expect(isExists, true);
    delay(5000);
    await driver.waitFor(logoFinder);
    //not sure how to click something that isn't labelled so the you must close the help box manually for now
  }, timeout: Timeout(Duration(seconds: 60)));

  //TODO: complete withdraw test
}

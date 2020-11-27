import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show delay, isPresent;

deleteMinerTest() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('delete miner', () async {
    await driver.tap(f['navBarMiners']);
    await driver.scrollIntoView(f['minersNewMiner']);
    await driver.waitFor(f['minersNewMiner']);
    await driver.scroll(f['minersNewMiner'], -100, 0, Duration(seconds: 1));
    print('SWIPE GATEWAY TO REVEAL DELETE');
    await driver.waitFor(f['minerDeleteButton']);
    await driver.tap(f['minerDeleteButton']);
    print('TAP DELETE BUTTON');
    await driver.waitFor(f['minerConfirmDeleteButton']);
    await driver.tap(f['minerConfirmDeleteButton']);
    print('CONFIRM DELETE');
    await delay(2000);
    var minerExists = await isPresent(f['minersNewMiner'], driver);
    expect(await minerExists, false);
    await driver.tap(f['navbarHomeButton']);
  }, timeout: Timeout(Duration(seconds: 60)));
}

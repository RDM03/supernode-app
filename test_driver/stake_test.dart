import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show delay, isPresent;

stakeTest() {
  FlutterDriver driver;

  group('staking tests', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('can set stake', () async {
      await driver.waitUntilFirstFrameRasterized();
      await driver.tap(f['stakeButtonDashboard']);
      print('tapped stake button');
      await driver.waitUntilNoTransientCallbacks();
      await driver.tap(f['stakeFlex']);
      for (var pageChanged = await isPresent(f['stakeAmount'], driver);
          pageChanged == false;
          pageChanged = await isPresent(f['stakeAmount'], driver)) {
        print('page not changed, tapping again');
        await driver.tap(f['stakeFlex']);
      }
      print('tapped stake Flex');
      await driver.scrollUntilVisible(f['stakeAmountView'], f['stakeAmount']);
      print('scrolled it visible');
      await driver.tap(f['stakeAmount']);
      print('tapped stake amount');
      await driver.enterText('20');
      print('entered 20');
      await driver.waitFor(find.text('20'));
      print('20 is there');
      await driver.tap(f['submitButton']);
      print('tapped stake button');
      await delay(31000);
      await driver.tap(f['submitButton']);
      print('Waited for the countdown, and proceeded anyways');
      expect(await isPresent(f['successIconFinder'], driver), true);
      await driver.tap(f['exitPage']);
      print('tapped exit confirm');
      await driver.scroll(
          f['stakeAmountView'], 0, 300, Duration(milliseconds: 500));
      await driver.tap(f['exitPage']);
      print('tapped exit stake amount page');
      await driver.tap(f['backButton']);
      print(
          'current page is ${await isPresent(f['depositButtonDashboard'], driver) ? "Home" : "Not home, we're lost"}');
    }, timeout: Timeout(Duration(seconds: 600)));
  });
}

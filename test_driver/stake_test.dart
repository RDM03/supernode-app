import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'utils.dart' show delay, isPresent;

stakeTest() {
  FlutterDriver driver;

  group('staking tests', () {
    final stakeFlex = find.byValueKey('stakeFlex');
    final stakeAmount = find.byValueKey('stakeAmount');
    final submitButton = find.byValueKey('submitButton');
    final backButtonFinder = find.byValueKey('backButton');
    final successIconFinder = find.byValueKey('successIcon');
    final stakeAmountView = find.byValueKey('stakeAmountView');
    final stakeButtonDashboard = find.byValueKey('stakeButtonDashboard');
    final depositButtonDashboard = find.byValueKey('depositButtonDashboard');
    final exitPage = find.byValueKey('navActionButton');

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
      await driver.tap(stakeButtonDashboard);
      print('tapped stake button');
      await driver.waitUntilNoTransientCallbacks();
      await driver.tap(stakeFlex);
      for (var pageChanged = await isPresent(stakeAmount, driver);
          pageChanged == false;
          pageChanged = await isPresent(stakeAmount, driver)) {
        print('page not changed, tapping again');
        await driver.tap(stakeFlex);
      }
      print('tapped stakeFlex');
      await driver.scrollUntilVisible(stakeAmountView, stakeAmount);
      print('scrolled it visible');
      await driver.tap(stakeAmount);
      print('tapped stake amount');
      await driver.enterText('20');
      print('entered 20');
      await driver.waitFor(find.text('20'));
      print('20 is there');
      await driver.tap(submitButton);
      print('tapped stake button');
      await delay(31000);
      await driver.tap(submitButton);
      print('Waited for the countdown, and proceeded anyways');
      expect(await isPresent(successIconFinder, driver), true);
      await driver.tap(exitPage);
      print('tapped exit confirm');
      await driver.scroll(stakeAmountView, 0, 300, Duration(milliseconds: 500));
      await driver.tap(exitPage);
      print('tapped exit stake amount page');
      await driver.tap(backButtonFinder);
      print(
          'current page is ${await isPresent(depositButtonDashboard, driver) ? "Home" : "Not home, we're lost"}');
    }, timeout: Timeout(Duration(seconds: 600)));
  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'utils.dart' show delay, isPresent;

helpBubbleTest() {
  FlutterDriver driver;
  group('help bubble tests', () {
    final infoDialog = find.byValueKey('infoDialog');
    final stakeButtonDashboard = find.byValueKey('stakeButtonDashboard');
    final questionCircle = find.byValueKey('questionCircle');
    final backButtonFinder = find.byValueKey('backButton');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('can use MXC Vault help bubble', () async {
      await driver.tap(stakeButtonDashboard);
      print('TAPPED STAKE BUTTON');
      await driver.tap(questionCircle);
      var isExists = await isPresent(find.byValueKey('helpText'), driver);
      expect(isExists, true);
      await driver.tap(infoDialog);
      await driver.tap(backButtonFinder);
    });
  });
}

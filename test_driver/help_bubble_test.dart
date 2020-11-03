import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show isPresent;

helpBubbleTest() {
  FlutterDriver driver;
  group('help bubble tests', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('can use MXC Vault help bubble', () async {
      await driver.tap(f['stakeButtonDashboard']);
      print('TAPPED STAKE BUTTON');
      await driver.tap(f['questionCircle']);
      var isExists = await isPresent(find.byValueKey('helpText'), driver);
      expect(isExists, true);
      await driver.tap(f['infoDialog']);
      await driver.tap(f['backButtonFinder']);
    });
  });
}

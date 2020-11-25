import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show delay, isPresent;

minerListAPITest() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('check miner list APIs', () async {
    await driver.waitUntilFirstFrameRasterized();
    await driver.tap(f['navBarMiners']);
    await delay(10000);
    print('MAKING SURE MINER LIST IS POPULATED CORRECTLY');
    var minerCountPresent = await isPresent(f['totalMinersSubtitle'], driver);
    expect(await minerCountPresent, true);
    var minerCount = int.parse(await driver.getText(f['totalMinersSubtitle']));
    print('MINER COUNT: ' + minerCount.toString());
    var revenuePresent = await isPresent(f['minersRevenue'], driver);
    expect(await revenuePresent, true);

    for(var i = 0; i < minerCount; i++){
      await driver.scrollIntoView(find.byValueKey('slide_gateway' + i.toString()));
      expect(await isPresent(find.byValueKey('slide_gateway' + i.toString()), driver), true);
    }
    await driver.tap(f['navbarHomeButton']);
  });
}
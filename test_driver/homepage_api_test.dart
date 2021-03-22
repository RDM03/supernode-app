import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show isPresent, delay;

homeAPITest() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('receives information from api', () async {
    await driver.waitUntilFirstFrameRasterized();
    await delay(10000);
    print('CHECKING FOR BALANCE');
    var currentBalancePresent = await isPresent(f['homeMXCCurrentBalance'], driver);
    expect(await currentBalancePresent, true);
    print('CHECKING FOR STAKED AMOUNT');
    var stakedAmountPresent = await isPresent(f['homeMXCStakedAmount'], driver);
    expect(await stakedAmountPresent, true);
    print('CHECKING FOR TOTAL REVENUE');
    var stakingRevenuePresent = await isPresent(f['homeMXCTotalRevenue'], driver);
    expect(await stakingRevenuePresent, true);
    print('CHECKING OTHER CURRENCIES');
    await driver.scroll(f['homeMXCCurrentBalance'], -500, 0, Duration(seconds: 1));
    //expect other currency
    print('CHECKING FOR MINERS');
    var minersPresent = await isPresent(f['totalGatewaysDashboard'], driver);
    expect(await minersPresent, true);
    print('CHECKING FOR DEVICES');
    var devicesPresent = await isPresent(f['totalDevicesDashboard'], driver);
    expect(await devicesPresent, true);
    print('SCROLLING TO MAPBOX');
    await driver.scrollIntoView(f['homeMapbox']);
    print('CHECKING FOR MAPBOX');
    var mapboxPresent = await isPresent(f['homeMapbox'], driver);
    expect(await mapboxPresent, true);
    await driver.scrollIntoView(f['homeProfile']);
  });
}
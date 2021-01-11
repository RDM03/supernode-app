import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show delay, isPresent;

minerDetailsAPITest() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('check miner details APIs', () async {
    await driver.waitUntilFirstFrameRasterized();
    await driver.tap(f['navBarMiners']);
    await delay(10000);
    await driver.scrollIntoView(f['minersNewMiner']);
    await driver.tap(f['minersNewMiner']);
    await delay(2000);
    expect(await isPresent(f['minerDetailsMapbox'], driver), true);
    print('MAPBOX PRESENT');
    expect(await isPresent(f['minerDetailsAltitude'], driver), true);
    print('ALTITUDE PRESENT');
    expect(await isPresent(f['minerDetailsCoordinates'], driver), true);
    print('COORDINATES PRESENT');
    expect(await isPresent(f['minerDetailsMinerId'], driver), true);
    print('MINDER ID PRESENT');
    driver.scrollIntoView(f['minerDetailsLastSeen']);
    expect(await isPresent(f['minerDetailsLastSeen'], driver), true);
    print('LAST SEEN PRESENT');
    driver.scrollIntoView(f['minerDetailsWeeklyRevenue']);
    expect(await isPresent(f['minerDetailsWeeklyRevenue'], driver), true);
    print('WEEKLY REVENUE PRESENT');
    // frame unable to be keyed
    // driver.scrollIntoView(f['minerDetailsFrame']);
    // expect(await isPresent(f['minerDetailsFrame'], driver), true);
    // print('FRAME PRESENT');
    driver.scrollIntoView(f['minerDetailsMinerModel']);
    expect(await isPresent(f['minerDetailsMinerModel'], driver), true);
    print('MINER MODEL PRESENT');
    expect(await isPresent(f['minerDetailsMinerOS'], driver), true);
    print('MINER OS PRESENT');
    driver.scrollIntoView(f['exitPage']);
    await driver.tap(f['exitPage']);
    print('EXITING MINER DETAILS');
    await driver.tap(f['navbarHomeButton']);
  });
}

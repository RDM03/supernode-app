import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'utils.dart' show isPresent, delay;
import 'finders.dart' show f;

addMinerTest() {
  load();

  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('add miner', () async {
    driver.tap(f['navBarMiners']);
    print('NAVIGATE TO MINERS MENU');
    await driver.waitFor(f['minersAddIcon']);
    await driver.tap(f['minersAddIcon']);
    print('TAP ADD MINER BUTTON');
    await driver.waitFor(f['addMinerAdvancedSettings']);
    await driver.tap(f['addMinerAdvancedSettings']);
    print('OPENED ADVANCED SETTINGS');
    await driver.waitFor(f['addMinerSerialNumber']);
    await driver.tap(f['addMinerSerialNumber']);
    await driver.enterText(env['DRIVE_MINER_SERIAL']);
    print('TYPED SERIAL NUMBER');
    await driver.waitFor(f['addMinerSubmit']);
    await driver.tap(f['addMinerSubmit']);
    print('SUBMITTED MINER');
    await delay(5000);
    var MinerExists = await isPresent(f['minersNewMiner'], driver);
    expect(await MinerExists, true);
    driver.tap(f['navbarHomeButton']);
  }, timeout:Timeout(Duration(seconds: 60)));
}
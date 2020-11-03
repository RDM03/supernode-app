import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;

isPresent(SerializableFinder byValueKey, FlutterDriver driver, {Duration timeout = const Duration(seconds: 20)}) async {
  try {
    await driver.waitFor(byValueKey,timeout: timeout);
    return true;
  } catch(exception) {
    return false;
  }
}

addMinerTest() {
  load();
  final bottomNavBar_Gateway = find.byValueKey('bottomNavBar_Gateway');
  final addMinerIcon = find.byValueKey('addMinerIcon');
  final minerSerialNumber = find.byValueKey('minerSerialNumber');
  final submitMiner = find.byValueKey('submitMiner');
  final slideMiner = find.text('Gateway_' + env['MINER_SERIAL']);
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
    driver.tap(bottomNavBar_Gateway);
    await driver.waitFor(addMinerIcon);
    await driver.tap(addMinerIcon);
    await driver.waitFor(minerSerialNumber);
    await driver.tap(minerSerialNumber);
    await driver.enterText(env['MINER_SERIAL']);
    await driver.waitFor(submitMiner);
    //can't tap submit button for some reason??
    await driver.tap(submitMiner);
    var MinerExists = await isPresent(slideMiner, driver);
    expect(MinerExists, true);
  }, timeout:Timeout(Duration(seconds: 60)));
}
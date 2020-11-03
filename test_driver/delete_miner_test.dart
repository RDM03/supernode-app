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
Future<void> delay([int milliseconds = 250]) async {
  await Future<void>.delayed(Duration(milliseconds: milliseconds));
}

deleteMinerTest() {
  load();
  final bottomNavBar_Gateway = find.byValueKey('bottomNavBar_Gateway');
  final deleteGatewayButton = find.text('Delete');
  final deleteGatewayConfirm = find.byValueKey('delete_gateway_bottom_dialog_item2');
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

  test('delete miner', () async {
    driver.tap(bottomNavBar_Gateway);
    await driver.waitFor(slideMiner);
    await driver.scroll(slideMiner, -100, 0, Duration(seconds: 1));
    await driver.waitFor(deleteGatewayButton);
    await driver.tap(deleteGatewayButton);
    await driver.waitFor(deleteGatewayConfirm);
    await driver.tap(deleteGatewayConfirm);
    delay(5000);
    var MinerExists = await isPresent(slideMiner, driver);
    expect(MinerExists, false);
  }, timeout:Timeout(Duration(seconds: 60)));
}
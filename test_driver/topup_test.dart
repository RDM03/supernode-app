import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

topupTest() {
  final depositButtonDashboard = find.byValueKey('depositButtonDashboard');
  final exitPage = find.byValueKey('navActionButton');
  final ethAddressTopUp = find.byValueKey('ethAddressTopUp');
  final qrCodeTopUp = find.byValueKey('qrCodeTopUp');

  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('has top up address', () async {
    print('CHECKING TOP-UP API');
    await driver.tap(depositButtonDashboard);
    await driver.tap(exitPage);
    await driver.tap(depositButtonDashboard);
    await driver.waitFor(qrCodeTopUp);
    expect(await driver.getText(ethAddressTopUp),
        '0x9bfd604ef6cbfdca05e9eae056bc465c570c09e8');
    await driver.tap(exitPage);
  }, timeout: Timeout(Duration(seconds: 60)));
}

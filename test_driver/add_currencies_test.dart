import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'utils.dart' show isPresent, delay;
import 'finders.dart' show f;

addCurrenciesTest() {
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

  //walletAddDHX, walletDHXPanel, walletAddBTC, and walletBTCPanel must be defined
  test('add DHX and BTC', () async {
    driver.tap(f['navBarWallet']);
    print('NAVIGATE TO WALLET MENU');
    await driver.scrollIntoView(f['walletAddCurrencies']);
    await driver.tap(f['walletAddCurrencies']);
    print('TAP ADD CURRENCY BUTTON');
    await driver.waitFor(f['walletAddDHX']);
    await driver.tap(f['walletAddDHX']);
    print('ADDED DHX TO WALLET');
    await delay(5000);
    var DHXExists = await isPresent(f['walletDHXPanel'], driver);
    print('CHECKING IF CURRENCY IS ADDED');
    expect(await DHXExists, true);
    await driver.scrollIntoView(f['walletAddCurrencies']);
    await driver.tap(f['walletAddCurrencies']);
    print('TAP ADD CURRENCY BUTTON');
    await driver.waitFor(f['walletAddBTC']);
    await driver.tap(f['walletAddBTC']);
    print('ADDED DHX TO WALLET');
    await delay(5000);
    var BTCExists = await isPresent(f['walletBTCPanel'], driver);
    print('CHECKING IF CURRENCY IS ADDED');
    expect(await BTCExists, true);
    driver.tap(f['navbarHomeButton']);
  }, timeout:Timeout(Duration(seconds: 60)));
}
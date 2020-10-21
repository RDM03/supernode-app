import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;


Future<void> delay([int milliseconds = 250]) async {
  await Future<void>.delayed(Duration(milliseconds: milliseconds));
}

void main() {
  load();

  group('Supernode App', () {

    // All-Purpose

    final exitPage = find.byValueKey('navActionButton');

    // Login Screen

    final logoFinder = find.byValueKey('homeLogo');
    final loginFinder = find.byValueKey('homeLogin');
    final menuFinder = find.byValueKey('homeSupernodeMenu');
    final emailFieldFinder = find.byValueKey('homeEmail');
    final passwordFieldFinder = find.byValueKey('homePassword');
    final testServerFinder = find.byValueKey('MXCbuild');
    final scrollMenu = find.byValueKey('scrollMenu');
    final mxcChinaFinder = find.byValueKey('MXCChina');

    // Dashboard

    final calculatorButtonDashboard = find.byValueKey('calculatorButton');
    final depositButtonDashboard = find.byValueKey('depositButtonDashboard');
    final checkEmailApi = find.text('test@mxc.org');
    final withdrawButtonDashboard = find.byValueKey('withdrawButtonDashboard');
    final totalGatewaysDashboard = find.byValueKey('totalGatewaysDashboard');

    // Top-Up Page

    final ethAddressTopUp = find.byValueKey('ethAddressTopUp');
    final qrCodeTopUp = find.byValueKey('qrCodeTopUp');


    FlutterDriver driver;

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('can login', () async {

      print('LOCATING THE MXC LOGO');

      await driver.waitFor(logoFinder);

      print('LOADED, BEGINNING THE TAP');

      for (var i = 0; i < 7; i++) {
        await driver.tap(logoFinder);
        delay(20);
        print('TAP ${i + 1}');
      }

      print('ALL TAPPED OUT, LETS SELECT THAT SERVER');

      await driver.tap(menuFinder);
      await driver.scrollUntilVisible(scrollMenu, mxcChinaFinder);
      await driver.tap(testServerFinder);

      print('SERVER SELECTED, TIME TO ENTER CREDENTIALS');

      await driver.waitFor(emailFieldFinder);
      await driver.tap(emailFieldFinder);
      await driver.enterText(env['TESTING_USER']);
      await driver.waitFor(find.text(env['TESTING_USER']));
      await driver.tap(passwordFieldFinder);
      await driver.enterText(env['TESTING_PASSWORD']);

      print('THE MOMENT HAS COME, WILL IT WORK?');

      await driver.tap(loginFinder);

      expect(await driver.getText(totalGatewaysDashboard), 'Revenue');

      print('HOUSTON, WE ARE LOGGED IN');

    });

    test('has top up address', () async {

      print('CHECKING TOP-UP API');

      await driver.tap(depositButtonDashboard);
      delay(2000);
      await driver.waitFor(qrCodeTopUp);
      expect(await driver.getText(ethAddressTopUp), '0x9bfd604ef6cbfdca05e9eae056bc465c570c09e8');
      await driver.tap(exitPage);

    });
  });
}
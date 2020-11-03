import 'package:dotenv/dotenv.dart' show load, env;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'utils.dart' show delay, canTap, isPresent;

loginPage() {
  final logoFinder = find.byValueKey('homeLogo');
  final loginFinder = find.byValueKey('homeLogin');
  final menuFinder = find.byValueKey('homeSupernodeMenu');
  final emailFieldFinder = find.byValueKey('homeEmail');
  final passwordFieldFinder = find.byValueKey('homePassword');
  final testServerFinder = find.byValueKey('MXCbuild');
  final scrollMenu = find.byValueKey('scrollMenu');
  final mxcChinaFinder = find.byValueKey('MXCChina');
  final questionCircle = find.byValueKey('questionCircle');
  final totalGatewaysDashboard = find.byValueKey('totalGatewaysDashboard');
  final helpTextFinder = find.byValueKey('helpText');
  final infoDialog = find.byValueKey('infoDialog');

  FlutterDriver driver;
  load();
  group('login page', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('login help bubble works', () async {
      await driver.waitUntilFirstFrameRasterized();

      print('LOCATING THE MXC LOGO');

      await driver.waitFor(logoFinder);

      print('CLICK QUESTION CIRCLE');
      await driver.waitFor(questionCircle);
      await driver.tap(questionCircle);
      // find solution for testing all languages
      await driver.waitFor(helpTextFinder);
      final helpTextExists = await isPresent(helpTextFinder, driver);
      expect(helpTextExists, true);
      await driver.tap(infoDialog);
    });

    test('can login', () async {
      await driver.waitUntilFirstFrameRasterized();
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
      await delay(2000);
      await driver.scrollUntilVisible(scrollMenu, mxcChinaFinder);
      var openMenuState = await canTap(testServerFinder, driver);
      print(openMenuState);
      if (openMenuState == true) {
        print('TEST SERVER SELECTED');
      } else {
        print("OOPS THE MENU CLOSED, I'LL JUST OPEN THAT UP FOR YOU");
        await driver.tap(menuFinder);
        await driver.tap(testServerFinder);
        print('SERVER SELECTED, TIME TO ENTER CREDENTIALS');
      }
      await driver.waitFor(emailFieldFinder);
      print('I SEE THE EMAIL FIELD');
      await driver.tap(emailFieldFinder);
      await driver.enterText(env['TESTING_USER']);
      await driver.waitFor(find.text(env['TESTING_USER']));
      await driver.tap(passwordFieldFinder);
      await driver.enterText(env['TESTING_PASSWORD']);
      print('THE MOMENT HAS COME, WILL IT WORK?');
      await driver.tap(loginFinder);
      expect(await driver.getText(totalGatewaysDashboard), 'Revenue');
      print('HOUSTON, WE ARE LOGGED IN');
    }, timeout: Timeout(Duration(seconds: 60)));
  });
}

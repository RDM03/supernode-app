import 'package:dotenv/dotenv.dart' show load, env;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show delay, canTap, isPresent;

loginPageTests(String server, String password) {
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

      await driver.waitFor(f['logoFinder']);

      print('CLICK QUESTION CIRCLE');
      await driver.waitFor(f['questionCircle']);
      await driver.tap(f['questionCircle']);
      // find solution for testing all languages
      await driver.waitFor(f['helpTextFinder']);
      final helpTextExists = await isPresent(f['helpTextFinder'], driver);
      expect(helpTextExists, true);
      await driver.tap(f['infoDialog']);
    });

    test('can login', () async {
      await driver.waitUntilFirstFrameRasterized();
      print('LOCATING THE MXC LOGO');
      await driver.waitFor(f['logoFinder']);
      print('LOADED, BEGINNING THE TAP');
      for (var i = 0; i < 7; i++) {
        await driver.tap(f['logoFinder']);
        delay(20);
        print('TAP ${i + 1}');
      }
      print('ALL TAPPED OUT, LETS SELECT THAT SERVER');
      await driver.tap(f['menuFinder']);
      await driver.scrollUntilVisible(f['scrollMenu'], find.byValueKey(server));
      await delay(2000);
      var openMenuState = await canTap(find.byValueKey(server), driver);
      if (await openMenuState == true) {
        print('SERVER SELECTED');
      } else {
        print("OOPS THE MENU CLOSED, I'LL JUST OPEN THAT UP FOR YOU");
        await driver.tap(f['menuFinder']);
        await delay(2000);
        await driver.tap(find.byValueKey(server));
        await delay(2000);
        print('SERVER SELECTED, TIME TO ENTER CREDENTIALS');
      }
      await driver.waitFor(f['emailFieldFinder']);
      print('I SEE THE EMAIL FIELD');
      await driver.tap(f['emailFieldFinder']);
      print('TAPPED EMAIL FIELD');
      await driver.enterText(env['TESTING_USER']);
      print('ENTERED EMAIL ADDRESS');
      await driver.tap(f['passwordFieldFinder']);
      print('TAPPED PASSWORD FIELD');
      await driver.enterText(password);
      print('THE MOMENT HAS COME, WILL IT WORK?');
      await driver.tap(f['loginFinder']);
      expect(await driver.getText(f['totalGatewaysDashboard']), 'Revenue');
      print('HOUSTON, WE ARE LOGGED IN');
    }, timeout: Timeout(Duration(seconds: 60)));
  });
}

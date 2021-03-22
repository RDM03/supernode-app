import 'package:dotenv/dotenv.dart' show load, env;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show delay, canTap;

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

    test('can login', () async {
      await driver.waitUntilFirstFrameRasterized();
      await driver.waitFor(f['homeMXCLogin']);
      await driver.tap(f['homeMXCLogin']);
      print('LOCATING THE MXC LOGO');
      await driver.waitFor(f['logoFinder']);
      for (var i = 0; i < 7; i++) {
        await driver.tap(f['logoFinder']);
        delay(20);
        print('TAP ${i + 1}');
      }
      print('LETS SELECT THAT SERVER');
      // Need a more elegant solution to going through all categories
      await driver.tap(f['menuFinder']);
      await delay(2000);
      await driver.tap(f['Korea']);
      await driver.tap(f['China']);
      await driver.scrollIntoView(f['Test']);
      await driver.tap(f['Europe']);
      await driver.tap(f['Oceania']);
      await driver.scrollIntoView(f['Test']);
      await driver.tap(f['Asia']);
      await driver.tap(f['America']);
      await driver.scrollIntoView(f['Test']);
      await driver.tap(f['Test']);
      var openMenuState = await canTap(find.byValueKey(server), driver);
      if (openMenuState == false) {
        await driver.scrollUntilVisible(
            f['scrollMenu'], find.byValueKey(server));
        openMenuState = await canTap(find.byValueKey(server), driver);
      }
      print('DELAY');
      await delay(2000);

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
      await driver.enterText(env['DRIVE_TESTING_USER']);
      print('ENTERED EMAIL ADDRESS');
      await driver.tap(f['passwordFieldFinder']);
      print('TAPPED PASSWORD FIELD');
      await driver.enterText(password);
      print('THE MOMENT HAS COME, WILL IT WORK?');
      await driver.tap(f['loginFinder']);
      print('HOUSTON, WE ARE LOGGED IN');
      expect(await driver.getText(f['mxcProfile']),
          env['DRIVE_TESTING_USER']);
    }, timeout: Timeout(Duration(seconds: 180)));
  });
}

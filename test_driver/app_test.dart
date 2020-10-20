import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

Future<void> delay([int milliseconds = 250]) async {
  await Future<void>.delayed(Duration(milliseconds: milliseconds));
}

void main() {

  group('Supernode App', () {

    final logoFinder = find.byValueKey('homeLogo');
    final loginFinder = find.byValueKey('homeLogin');
    final menuFinder = find.byValueKey('homeSupernodeMenu');
    final emailFieldFinder = find.byValueKey('homeEmail');
    final passwordFieldFinder = find.byValueKey('homePassword');
    final testServerFinder = find.byValueKey('MXCbuild');
    final scrollMenu = find.byValueKey('scrollMenu');

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

      print('LOGO FOUND, BEGINNING THE TAP');

      for (var i = 0; i < 7; i++) {
        await driver.tap(logoFinder);
        delay(20);
        print('TAP ${i + 1}');
      }

      print('ALL TAPPED OUT, LETS SELECT THAT SERVER');

      await driver.tap(menuFinder);
      await driver.scrollUntilVisible(scrollMenu, testServerFinder);
      await driver.tap(testServerFinder);

      print('SERVER SELECTED, TIME TO ENTER CREDENTIALS');

      await driver.waitFor(emailFieldFinder);
      await driver.tap(emailFieldFinder);
      await driver.enterText('test@mxc.org');
      await driver.waitFor(find.text('test@mxc.org'));
      await driver.tap(passwordFieldFinder);
      await driver.enterText('ADDPASSWORD');

      print('THE MOMENT HAS COME, WILL IT WORK?');

      await driver.tap(loginFinder);

      print('HOUSTON, WE ARE LOGGED IN');

    });
  });
}
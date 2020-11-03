import 'package:dotenv/dotenv.dart' show load, env;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'login_test.dart' show loginPage;
import 'utils.dart' show delay, canTap, isPresent;

void main() {
  load();

  group('Supernode App', () {
    // All-Purpose

    final exitPage = find.byValueKey('navActionButton');
    final settingsPageFinder = find.byValueKey('settingsPage');

    // Login Screen

    final logoFinder = find.byValueKey('homeLogo');
    final loginFinder = find.byValueKey('homeLogin');
    final menuFinder = find.byValueKey('homeSupernodeMenu');
    final emailFieldFinder = find.byValueKey('homeEmail');
    final passwordFieldFinder = find.byValueKey('homePassword');
    final testServerFinder = find.byValueKey('MXCbuild');
    final scrollMenu = find.byValueKey('scrollMenu');
    final mxcChinaFinder = find.byValueKey('MXCChina');
    final questionCircle = find.byValueKey('questionCircle');

    // Dashboard

    final calculatorButtonDashboard = find.byValueKey('calculatorButton');
    final depositButtonDashboard = find.byValueKey('depositButtonDashboard');
    final checkEmailApi = find.text('test@mxc.org');
    final withdrawButtonDashboard = find.byValueKey('withdrawButtonDashboard');
    final totalGatewaysDashboard = find.byValueKey('totalGatewaysDashboard');
    final stakeButtonDashboard = find.byValueKey('stakeButtonDashboard');
    final settingsButtonDashboard = find.byValueKey('settingsButton');

    // Top-Up Page

    final ethAddressTopUp = find.byValueKey('ethAddressTopUp');
    final qrCodeTopUp = find.byValueKey('qrCodeTopUp');

    // Stake Page

    final stakeFlex = find.byValueKey('stakeFlex');
    final stakeAmount = find.byValueKey('stakeAmount');
    final submitButton = find.byValueKey('submitButton');
    final backButtonFinder = find.byValueKey('backButton');
    final successIconFinder = find.byValueKey('successIcon');
    final stakeAmountView = find.byValueKey('stakeAmountView');

    // Question Circles

    final helpTextFinder = find.byValueKey('helpText');
    final infoDialog = find.byValueKey('infoDialog');

    // Settings
    final logoutFinder = find.byValueKey('logout');

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

    loginPage();

    // test('has top up address', () async {
    //
    //   print('CHECKING TOP-UP API');
    //   await driver.tap(depositButtonDashboard);
    //   await driver.tap(exitPage);
    //   await driver.tap(depositButtonDashboard);
    //   await driver.waitFor(qrCodeTopUp);
    //   expect(await driver.getText(ethAddressTopUp), '0x9bfd604ef6cbfdca05e9eae056bc465c570c09e8');
    //   await driver.tap(exitPage);
    //
    // }, timeout:Timeout(Duration(seconds: 60)));

    // test('can withdraw', () async {
    //       print('NAVIGATE TO WITHDRAW');
    //       await driver.waitFor(withdrawButtonDashboard);
    //       await driver.tap(withdrawButtonDashboard);
    //       print('CHECKING ? BUTTON');
    //       await driver.waitFor(questionCircle);
    //       await driver.tap(questionCircle);
    //       delay(5000);
    //       var isExists = await isPresent(helpTextFinder, driver);
    //       expect(isExists, true);
    //       delay(5000);
    //       await driver.waitFor(logoFinder);
    //       //not sure how to click something that isn't labelled so the you must close the help box manually for now
    // }, timeout:Timeout(Duration(seconds: 60)));

    //complete withdraw test

    test('can set stake', () async {
      await driver.waitUntilFirstFrameRasterized();
      await driver.tap(stakeButtonDashboard);
      print('tapped stake button');
      await driver.waitUntilNoTransientCallbacks();
      await driver.tap(stakeFlex);
      for (var pageChanged = await isPresent(stakeAmount, driver);
          pageChanged == false;
          pageChanged = await isPresent(stakeAmount, driver)) {
        print('page not changed, tapping again');
        await driver.tap(stakeFlex);
      }
      print('tapped stakeFlex');
      await driver.scrollUntilVisible(stakeAmountView, stakeAmount);
      print('scrolled it visible');
      await driver.tap(stakeAmount);
      print('tapped stake amount');
      await driver.enterText('20');
      print('entered 20');
      await driver.waitFor(find.text('20'));
      print('20 is there');
      await driver.tap(submitButton);
      print('tapped stake button');
      await delay(31000);
      await driver.tap(submitButton);
      print('Waited for the countdown, and proceeded anyways');
      expect(await isPresent(successIconFinder, driver), true);
      await driver.tap(exitPage);
      print('tapped exit confirm');
      await driver.scroll(stakeAmountView, 0, 300, Duration(milliseconds: 500));
      await driver.tap(exitPage);
      print('tapped exit stake amount page');
      await driver.tap(backButtonFinder);
      print(
          'current page is ${await isPresent(depositButtonDashboard, driver) ? "Home" : "Not home, we're lost"}');
    }, timeout: Timeout(Duration(seconds: 600)));

    test('can use MXC Vault help bubble', () async {
      await driver.tap(stakeButtonDashboard);
      print('TAPPED STAKE BUTTON');
      await driver.tap(questionCircle);
      var isExists = await isPresent(find.byValueKey('helpText'), driver);
      expect(isExists, true);
      await driver.tap(infoDialog);
      await driver.tap(backButtonFinder);
    });

    test('can logout', () async {
      await driver.tap(settingsButtonDashboard);
      await driver.scrollIntoView(logoutFinder);
      await driver.tap(logoutFinder);
      await driver.waitFor(logoFinder);
      final logoIsPresent = await isPresent(logoFinder, driver);
      expect(logoIsPresent, true);
    });
  });
}

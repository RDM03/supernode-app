import 'package:dotenv/dotenv.dart' show load, env;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'finders.dart' show f;
import 'utils.dart' show delay, isPresent, getOtp;

stakingTest() {
  load();
  FlutterDriver driver;

  group('staking tests', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('can set stake', () async {
      await driver.waitUntilFirstFrameRasterized();
      await driver.tap(f['stakeButtonDashboard']);
      print('TAPPED STAKE BUTTON');
      await driver.waitUntilNoTransientCallbacks();
      await driver.tap(f['stakeFlex']);
      for (var pageChanged = await isPresent(f['stakeAmount'], driver);
          pageChanged == false;
          pageChanged = await isPresent(f['stakeAmount'], driver)) {
        print('PAGE NOT CHANGING, TAPPING AGAIN');
        await driver.tap(f['stakeFlex']);
      }
      print('TAPPED STAKE FLEX');
      await driver.scrollUntilVisible(f['stakeAmountView'], f['stakeAmount']);
      print('SCROLLED IT VISIBLE');
      await driver.tap(f['stakeAmount']);
      print('TAPPED STAKE AMOUNT');
      await driver.enterText('20');
      print('ENTERED 20');
      await driver.waitFor(find.text('20'));
      print('20 IS THERE');
      await driver.tap(f['submitButton']);
      print('TAPPED STAKE BUTTON');
      await delay(31000);
      await driver.tap(f['submitButton']);
      print('WAITED FOR THE COUNTDOWN, AND PROCEEDED');
      expect(await isPresent(f['successIconFinder'], driver), true);
      await driver.tap(f['exitPage']);
      print('TAPPED EXIT CONFIRM');
      await driver.scroll(
          f['stakeAmountView'], 0, 300, Duration(milliseconds: 500));
      await driver.tap(f['exitPage']);
      print('TAPPED STAKE EXIT');
      await driver.tap(f['backButton']);
      print(
          'CURRENT PAGE IS: ${await isPresent(f['depositButtonDashboard'], driver) ? "HOME" : "NOT HOME, WE ARE LOST"}');
    }, timeout: Timeout(Duration(seconds: 120)));

    test('can unstake', () async {
      await driver.tap(f['navbarWalletButton']);
      print('TAPPED TO WALLET');
      await driver.tap(f['walletAccountStakeButton']);
      print('TAPPED TO STAKE TAB');
      await driver.tap(f['walletStakeUnstakeButton']);
      print('TAPPED TO UNSTAKE');

      // TODO: tap specific stake to unstake
      await driver.scrollIntoView(f['unstakeStakedToken']);
      print('SCROLLED INTO VIEW');
      await driver.tap(f['unstakeStakedToken']);
      print('TAPPED TOKEN TO UNSTAKE');
      await delay(3000);
      await driver.tap(f['primaryButton']);
      print('TAPPED UNSTAKE');
      await driver.tap(f['otpEnterOtp']);
      print('READY TO ENTER OTP');
      var otp = getOtp(env['OTP_KEY']);
      print('Here is the OTP: $otp');
      await driver.enterText(otp);
      print('KEY ENTERED');
      await driver.tap(f['otpConfirmOtpButton']);
      print('UNSTAKE IN PROGRESS');
      expect(await isPresent(f['successIconFinder'], driver), true);
      print('RETURNING TO HOME');
      await driver.tap(f['exitPage']);
      await driver.tap(f['navbarHomeButton']);
      print(
          'CURRENT PAGE IS: ${await isPresent(f['depositButtonDashboard'], driver) ? "HOME" : "NOT HOME, WE ARE LOST"}');
    }, timeout: Timeout(Duration(seconds: 150)));
  });
}

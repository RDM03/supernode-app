import 'package:flutter_driver/flutter_driver.dart';

// Naming Convention 'page' + 'DescribeItem'

Map f = {
  'logoFinder': find.byValueKey('homeLogo'),
  'loginFinder': find.byValueKey('homeLogin'),
  'menuFinder': find.byValueKey('homeSupernodeMenu'),
  'emailFieldFinder': find.byValueKey('homeEmail'),
  'passwordFieldFinder': find.byValueKey('homePassword'),
  'testServerFinder': find.byValueKey('MXCbuild'),
  'scrollMenu': find.byValueKey('scrollMenu'),
  'mxcChinaFinder': find.byValueKey('MXCChina'),
  'questionCircle': find.byValueKey('questionCircle'),
  'totalGatewaysDashboard': find.byValueKey('totalGatewaysDashboard'),
  'helpTextFinder': find.byValueKey('helpText'),
  'infoDialog': find.byValueKey('infoDialog'),
  'stakeFlex': find.byValueKey('stakeFlex'),
  'stakeAmount': find.byValueKey('stakeAmount'),
  'submitButton': find.byValueKey('submitButton'),
  'backButton': find.byValueKey('backButton'),
  'successIconFinder': find.byValueKey('successIcon'),
  'stakeAmountView': find.byValueKey('stakeAmountView'),
  'stakeButtonDashboard': find.byValueKey('stakeButtonDashboard'),
  'depositButtonDashboard': find.byValueKey('depositButtonDashboard'),
  'exitPage': find.byValueKey('navActionButton'),
  'settingsButtonDashboard': find.byValueKey('settingsButton'),
  'logoutFinder': find.byValueKey('logout'),
  'navbarWalletButton': find.byValueKey('bottomNavBar_Wallet'),
  'walletAccountStakeButton': find.byValueKey('tabBar_stake'),
  'walletStakeUnstakeButton': find.byValueKey('unstake'),

  // Later unstakeStakedToken will need to be managed directly in the staking_test.dart file
  // so that we can unstake specific to the recently created stake

  'unstakeStakedToken': find.byValueKey('stakeItem_1'),
  'primaryButton': find.byValueKey('primaryButton'),
  'otpEnterOtp': find.byValueKey('otp_0'),
  'otpConfirmOtpButton': find.byValueKey('confirmOtp'),
  'navbarHomeButton': find.byValueKey('bottomNavBar_Home'),
  'unstakeStakesList': find.byValueKey('stakesList'),
  'unstakePage': find.byValueKey('unstakePage')
};

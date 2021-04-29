import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dotenv/dotenv.dart' show env;

// Naming Convention 'page' + 'DescribeItem'

Map f = {
  'logoFinder': find.byKey(Key('homeLogo')),
  'loginFinder': find.byKey(Key('homeLogin')),
  'menuFinder': find.byKey(Key('homeSupernodeMenu')),
  'navBarMiners': find.byKey(Key('bottomNavBar_Gateway')),
  'emailFieldFinder': find.byKey(Key('homeEmail')),
  'passwordFieldFinder': find.byKey(Key('homePassword')),
  'scrollMenu': find.byKey(Key('scrollMenu')),
  'mxcChinaFinder': find.byKey(Key('MXCChina')),
  'questionCircle': find.byKey(Key('questionCircle')),
  'totalGatewaysDashboard': find.byKey(Key('totalGatewaysDashboard')),
  'helpTextFinder': find.byKey(Key('helpText')),
  'infoDialog': find.byKey(Key('infoDialog')),
  'stakeFlex': find.byKey(Key('stakeFlex')),
  'stakeAmount': find.byKey(Key('stakeAmount')),
  'minersAddIcon': find.byKey(Key('minersAddIcon')),
  'totalMinersTitle': find.byKey(Key('totalMinersTitle')),
  'totalMinersSubtitle': find.byKey(Key('totalMinersSubtitle')),
  'minersRevenue': find.byKey(Key('minersRevenue')),
  'addMinerSerialNumber': find.byKey(Key('addMinerSerialNumber')),
  'addMinerSubmit': find.byKey(Key('addMinerSubmit')),
  'minersNewMiner': find.text('Gateway_' + env['DRIVE_MINER_SERIAL']),
  'minerDeleteButton': find.text('Delete'),
  'minerConfirmDeleteButton':
      find.byKey(Key('delete_gateway_bottom_dialog_item2')),
  'minerDetailsMapbox': find.byKey(Key('minerDetailsMapbox')),
  'minerDetailsAltitude': find.byKey(Key('minerDetailsAltitude')),
  'minerDetailsCoordinates': find.byKey(Key('minerDetailsCoordinates')),
  'minerDetailsMinerId': find.byKey(Key('minerDetailsMinerId')),
  'minerDetailsLastSeen': find.byKey(Key('minerDetailsLastSeen')),
  'minerDetailsWeeklyRevenue': find.byKey(Key('miningChart')),
  'minerDetailsFrame': find.byKey(Key('minerDetailsFrame')),
  'minerDetailsMinerModel': find.byKey(Key('minerDetailsMinerModel')),
  'minerDetailsMinerOS': find.byKey(Key('minerDetailsMinerOS')),
  'submitButton': find.byKey(Key('submitButton')),
  'backButton': find.byKey(Key('backButton')),
  'successIconFinder': find.byKey(Key('successIcon_true')),
  'stakeAmountView': find.byKey(Key('stakeAmountView')),
  'stakeButtonDashboard': find.byKey(Key('stakeButtonDashboard')),
  'depositButtonDashboard': find.byKey(Key('depositButtonDashboard')),
  'exitPage': find.byKey(Key('navActionButton')),
  'settingsButtonDashboard': find.byKey(Key('settingsButton')),
  'logoutFinder': find.byKey(Key('logout')),
  'navbarWalletButton': find.byKey(Key('bottomNavBar_Wallet')),
  'walletAccountStakeButton': find.byKey(Key('tabBar_stake')),
  'walletStakeUnstakeButton': find.byKey(Key('unstake')),
  'homeProfile': find.byKey(Key('homeProfile')),
  'homeProfileSubtitle': find.byKey(Key('homeProfileSubtitle')),
  'totalDevicesDashboard': find.byKey(Key('totalDevicesDashboard')),
  'homeCurrentBalanceLabel': find.byKey(Key('homeCurrentBalanceLabel')),
  'homeCurrentBalance': find.byKey(Key('homeCurrentBalance')),
  'homeStakedAmountLabel': find.byKey(Key('homeStakedAmountLabel')),
  'homeStakedAmount': find.byKey(Key('homeStakedAmount')),
  'homeStakingRevenueLabel': find.byKey(Key('homeStakingRevenueLabel')),
  'homeStakingRevenue': find.byKey(Key('homeStakingRevenue')),
  'homeMapbox': find.byKey(Key('homeMapbox')),

  // Later unstakeStakedToken will need to be managed directly in the staking_test.dart file
  // so that we can unstake specific to the recently created stake

  'unstakeStakedToken': find.byKey(Key('stakeItem_0')),
  'primaryButton': find.byKey(Key('primaryButton')),
  'otpEnterOtp': find.byKey(Key('otp_0')),
  'otpConfirmOtpButton': find.byKey(Key('confirmOtp')),
  'navbarHomeButton': find.byKey(Key('bottomNavBar_Home')),
  'unstakeStakesList': find.byKey(Key('stakesList')),
  'unstakePage': find.byKey(Key('unstakePage'))
};

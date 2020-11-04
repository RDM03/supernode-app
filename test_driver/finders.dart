import 'package:flutter_driver/flutter_driver.dart';
import 'package:dotenv/dotenv.dart' show load, env;

// Naming Convention 'page' + 'DescribeItem'

Map f = {
  'logoFinder': find.byValueKey('homeLogo'),
  'loginFinder': find.byValueKey('homeLogin'),
  'menuFinder': find.byValueKey('homeSupernodeMenu'),
  'navBarMiners': find.byValueKey('bottomNavBar_Gateway'),
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
  'minersAddIcon': find.byValueKey('minersAddIcon'),
  'addMinerSerialNumber': find.byValueKey('addMinerSerialNumber'),
  'addMinerSubmit': find.byValueKey('addMinerSubmit'),
  'minersNewMiner': find.text('Gateway_' + env['MINER_SERIAL']),
  'minerDeleteButton': find.text('Delete'),
  'minerConfirmDeleteButton': find.byValueKey('delete_gateway_bottom_dialog_item2'),
  'submitButton': find.byValueKey('submitButton'),
  'backButton': find.byValueKey('backButton'),
  'successIconFinder': find.byValueKey('successIcon'),
  'stakeAmountView': find.byValueKey('stakeAmountView'),
  'stakeButtonDashboard': find.byValueKey('stakeButtonDashboard'),
  'depositButtonDashboard': find.byValueKey('depositButtonDashboard'),
  'exitPage': find.byValueKey('navActionButton'),
  'settingsButtonDashboard': find.byValueKey('settingsButton'),
  'logoutFinder': find.byValueKey('logout')
};

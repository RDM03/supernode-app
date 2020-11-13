import 'package:dotenv/dotenv.dart' show env;

List s = [
  ['Enlink', env['DRIVE_ENLINK_PASSWORD'], env['DRIVE_ENLINK_OTP_KEY']],
  ['XY', env['DRIVE_XY_PASSWORD'], env['DRIVE_XY_OTP_KEY']],
  //['Huaweitech', env['DRIVE_HUAWEITECH_PASSWORD'], env['DRIVE_HUAWEITECH_OTP_KEY']],
  ['MatchX EU', env['DRIVE_MATCHXEU_PASSWORD'], env['DRIVE_MATCHXEU_OTP_KEY']],
  ['Sejong', env['DRIVE_SEJONG_PASSWORD'], env['DRIVE_SEJONG_OTP_KEY']],
  ['MXCtest', env['DRIVE_MXCTEST_PASSWORD'], env['DRIVE_MXCTEST_OTP_KEY']],
  ['MXCbuild', env['DRIVE_MXCBUILD_PASSWORD'], env['DRIVE_MXCBUILD_OTP_KEY']]
  //['MXCChina', env['DRIVE_MXCCHINA_PASSWORD'], env['DRIVE_MXCCHINA_OTP_KEY']]
];

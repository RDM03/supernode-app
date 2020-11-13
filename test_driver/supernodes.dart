import 'package:dotenv/dotenv.dart' show env;

List s = [
  ['Enlink', env['ENLINK_PASSWORD'], env['ENLINK_OTP_KEY']],
  ['XY', env['XY_PASSWORD'], env['XY_OTP_KEY']],
  //['Huaweitech', env['HUAWEITECH_PASSWORD'], env['HUAWEITECH_OTP_KEY']],
  ['MatchX EU', env['MATCHXEU_PASSWORD'], env['MATCHXEU_OTP_KEY']],
  ['Sejong', env['SEJONG_PASSWORD'], env['SEJONG_OTP_KEY']],
  ['MXCtest', env['MXCTEST_PASSWORD'], env['MXCTEST_OTP_KEY']],
  ['MXCbuild', env['MXCBUILD_PASSWORD'], env['MXCBUILD_OTP_KEY']]
  //['MXCChina', env['MXCCHINA_PASSWORD'], env['MXCCHINA_OTP_KEY']]
];

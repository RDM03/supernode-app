import 'package:dotenv/dotenv.dart' show env;

Map s = {
  'Enlink': env['ENLINK_PASSWORD'],
  'XY': env['XY_PASSWORD'],
  'Huaweitech': env['HUAWEITECH_PASSWORD'],
  'MatchX EU': env['MATCHXEU_PASSWORD'],
  'Sejong': env['SEJONG_PASSWORD'],
  'MXCtest': env['MXCBUILD_PASSWORD'],
  'MXCbuild': env['MXCTEST_PASSWORD'],
  'MXCChina': env['MXCCHINA_PASSWORD']
};


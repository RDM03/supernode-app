import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static const bool debug = true;
  static const String WECHAT_APP_ID = "wx7fcea6540bed2f37"; //production
  static const String WECHAT_APP_ID_DEBUG = "wx7fcea6540bed2f37"; //debug
  static const double BLUE_PRINT_WIDTH = 375;
  static const double BLUE_PRINT_HEIGHT = 812;
  static final String JIRA_PROJECT_KEY = DotEnv().env['JIRA_PROJECT_KEY'];
  static final String JIRA_AUTH = DotEnv().env['JIRA_AUTH'];
  static final String MAP_BOX_ACCESS_TOKEN =
      DotEnv().env['MAP_BOX_ACCESS_TOKEN'];
}

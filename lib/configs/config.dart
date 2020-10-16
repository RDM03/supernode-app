import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static const bool DEBUG = true;
  static const String TOKEN_KEY = "jwt";
  static const String USER_KEY = "user";
  static const String DEMO_MODE = 'demo_mode';
  static const String USERNAME_KEY = 'username';
  static const String PASSWORD_KEY = 'password';
  static const String API_ROOT = 'api_root';
  static const double BLUE_PRINT_WIDTH = 375;
  static const double BLUE_PRINT_HEIGHT = 812;
  static final String JIRA_PROJECT_KEY = DotEnv().env['JIRA_PROJECT_KEY'];
  static final String JIRA_AUTH = DotEnv().env['JIRA_AUTH'];
  static final String MAP_BOX_ACCESS_TOKEN =
      DotEnv().env['MAP_BOX_ACCESS_TOKEN'];
}

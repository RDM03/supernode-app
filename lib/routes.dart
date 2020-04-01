import 'package:flutter/material.dart';

import 'ui/login/login_screen.dart';
import 'ui/splash/splash_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
  };
}

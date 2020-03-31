import 'package:flutter/material.dart';
import 'package:supernodeapp/routes.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/ui/splash/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: appTheme,
      routes: Routes.routes,
      home: SplashScreen(),
    );
  }
}

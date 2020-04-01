import 'package:flutter/material.dart';
import 'package:supernodeapp/router_service.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/ui/splash/splash.dart';

void main() {
  RouterService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: appTheme,
      onGenerateRoute: RouterService.instance.generator,
      home: SplashScreen(),
    );
  }
}

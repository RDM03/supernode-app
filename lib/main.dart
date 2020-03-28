import 'package:flutter/material.dart';
import 'package:supernodeapp/routes.dart';
import 'package:supernodeapp/ui/splash/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Routes.routes,
      home: SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../route.dart';
import 'login.dart';

class LogInRoute extends ARoute {
  static String _path = '/login';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => LoginScreen();
}

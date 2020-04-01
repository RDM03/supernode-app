import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/route.dart';

import 'login.dart';

class LogInRoute extends ARoute {
  static String _path = '/login';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final bool clearStack = true;

  @override
  final TransitionType transition = TransitionType.fadeIn;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => LoginScreen();
}
